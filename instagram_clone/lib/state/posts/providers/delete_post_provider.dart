// final deletePostProvifer=
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/image_upload/typedef/is_loading_typedef.dart';
import 'package:instagram_clone/state/posts/notifier/delete_post_state_notifier.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, LoadingState>((
  ref,
) =>
        DeletePostStateNotifier());
