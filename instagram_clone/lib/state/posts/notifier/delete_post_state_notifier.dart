import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/extension/get_collection_name_from%20_filetype.dart';
import 'package:instagram_clone/state/image_upload/typedef/is_loading_typedef.dart';

import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';
import '../models/post.dart';
import '../typedefs/user_id.dart';

class DeletePostStateNotifier extends StateNotifier<LoadingState> {
  DeletePostStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletePost({
    required Post post,
  }) async {
    try {
      isLoading = true;

      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.thumbnailStorageId)
          .delete();

      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.collectionName)
          .child(post.originalFileStorageId)
          .delete();

      await _deleteAllDocuments(
        inCollection: FirebaseCollectionName.comments,
        postId: post.postId,
      );

      await _deleteAllDocuments(
        inCollection: FirebaseCollectionName.likes,
        postId: post.postId,
      );

      final postInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(
            FieldPath.documentId,
            isEqualTo: post.postId,
          )
          .limit(1)
          .get();
      for (final post in postInCollection.docs) {
        await post.reference.delete();
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAllDocuments({
    required PostId postId,
    required String inCollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(
        seconds: 20,
      ),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(
              FirebaseFieldName.postId,
              isEqualTo: postId,
            )
            .get();
        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }
}
