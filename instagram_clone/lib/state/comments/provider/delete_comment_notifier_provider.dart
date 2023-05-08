import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/typedef/is_loading_typedef.dart';

import '../notifier/delete_comment_notifier.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, LoadingState>(
  (ref) => DeleteCommentStateNotifier(),
);
