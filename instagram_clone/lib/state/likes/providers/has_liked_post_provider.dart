import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/provider/user_id_provier.dart';
import 'package:instagram_clone/state/constants/firebase_collection_name.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

final hasLikedPostProvider =
    StreamProvider.family.autoDispose<bool, PostId>((ref, postId) {
  final userId = ref.watch(userIdProvider);

  if (userId == null) {
    return Stream<bool>.value(false);
  }
  final controller = StreamController<bool>();
  final subscription = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .where(FirebaseFieldName.userId, isEqualTo: userId)
      .snapshots()
      .listen((event) {
    if (event.docs.isNotEmpty) {
      controller.add(true);
    } else {
      controller.add(false);
    }
  });
  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  return controller.stream;
});
