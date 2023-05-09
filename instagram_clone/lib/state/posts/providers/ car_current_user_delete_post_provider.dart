import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/provider/user_id_provier.dart';

import '../models/post.dart';

final canCurrentUserDeletePostProvider =
    StreamProvider.autoDispose.family<bool, Post>(
  (ref, Post post) async* {
    final userId = ref.watch(userIdProvider);
    yield userId == post.userId;
  },
);
