import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_clone/state/constants/firebase_field_name.dart';
import 'package:instagram_clone/state/posts/typedefs/user_id.dart';

@immutable
class Like extends MapView<String, String> {
  Like({required PostId postId, required likedBy, required DateTime date})
      : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: likedBy,
          FirebaseFieldName.date: date.toIso8601String(),
        });
}
