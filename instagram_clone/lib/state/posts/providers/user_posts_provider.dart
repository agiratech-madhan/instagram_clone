import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/provider/user_id_provier.dart';
import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';
import '../models/post.dart';
import '../models/post_key.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<Post>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true,
        )
        .where(
          PostKey.userId,
          isEqualTo: userId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        // print("userpost snapshot ${snapshot}");
        // // print("userpost snapshot ${snapshot}");
        // print("userpost docs ${snapshot.docs}");
        // print("userpost docs length ${snapshot.docs.length}");
        // print("userpost docs first reference ${snapshot.docs.first.reference}");
        // print(
        //     "userpost docs first metadata runTimeType ${snapshot.docs.first.metadata}");
        // print("userpost docs first metadata  ${snapshot.docs.first.metadata}");
        // print("userpost metadata ${snapshot.metadata}");
        // print(
        //     "userpost metadata hasPendingWrites ${snapshot.metadata.hasPendingWrites}");
        // print("userpost docChanges ${snapshot.docChanges}");
        // print("userpost docChanges  length ${snapshot.docChanges.length}");
        // print("userpost size ${snapshot.size}");
        // // snapshot.docs.forEach((element) => print(element.data()));
        // // print("userpost size ${snapshot.docs.forEach((element) => print)}");

        final posts = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Post(
                postId: doc.id,
                json: doc.data(),
              ),
            );
        controller.sink.add(posts);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
