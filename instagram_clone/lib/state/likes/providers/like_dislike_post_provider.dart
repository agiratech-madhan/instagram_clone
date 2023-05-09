import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/likes/models/like.dart';
import 'package:instagram_clone/state/likes/models/likes_dislikes_request.dart';

final likeDislikeProvider = FutureProvider.family
    .autoDispose<bool, LikeDislikeRequest>((ref, request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .where(
        FirebaseFieldName.userId,
        isEqualTo: request.uerId,
      )
      .get();
  final hasLiked = await query.then((value) => value.docs.isNotEmpty);
  if (hasLiked) {
    try {
      await query.then((value) async {
        for (final doc in value.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  } else {
    final like = Like(
        postId: request.postId, likedBy: request.uerId, date: DateTime.now());

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(like);
      return true;
    } catch (e) {
      return false;
    }
  }
});
