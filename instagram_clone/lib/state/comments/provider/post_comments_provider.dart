import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/comments/extension/soting_comments.dart';
import 'package:instagram_clone/state/comments/model/post_coment_request.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';

import '../../constants/firebase_field_name.dart';
import '../model/comment.dart';

final postCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>((
  ref,
  RequestForPostAndComments request,
) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: request.postId,
      )
      .snapshots()
      .listen(
    (snapshot) {
      final documents = snapshot.docs;
      final limitedDocuments =
          request.limit != null ? documents.take(request.limit!) : documents;
      final comments = limitedDocuments
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (document) => Comment(
              id: document.id,
              document.data(),
            ),
          );

      final result = comments.applySortingFrom(request);
      controller.sink.add(result);
    },
  );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
