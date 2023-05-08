import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/typedef/is_loading_typedef.dart';

import '../notifier/send_comment_notifier.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, LoadingState>(
  (ref) => SendCommentNotifier(),
);
