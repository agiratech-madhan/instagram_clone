// ignore_for_file: file_names

import 'package:instagram_clone/state/auth/provider/user_id_provier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/post.dart';

// /To Check the whether the post have delete option
final canCurrentUserDeletePostProvider =
    StreamProvider.autoDispose.family<bool, Post>(
  (ref, Post post) async* {
    ///watch use user to delete post
    final userId = ref.watch(userIdProvider);
    yield userId == post.userId;
  },
);
