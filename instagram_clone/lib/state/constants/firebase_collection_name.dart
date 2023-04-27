import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const thumbnails = 'thumbnails';
  static const comments = 'comment';
  static const likes = 'likes';
  static const posts = 'posts';
  static const users = 'user';

  const FirebaseCollectionName._();
}
