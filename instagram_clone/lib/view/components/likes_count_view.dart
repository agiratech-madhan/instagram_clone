// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/likes/providers/post_likes_count_provider.dart';

import '../../state/posts/typedefs/user_id.dart';
import 'animations/loading_animation_view.dart';
import 'animations/small_error_animation_view.dart';
import 'constants/strings.dart';

class LikesCountView extends HookConsumerWidget {
  final PostId postId;
  const LikesCountView({required this.postId, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikesCountProvider(
        postId,
      ),
    );
    return likesCount.when(
      data: (int likesCount) {
        final personOrpeople =
            likesCount == 1 ? Strings.person : Strings.people;
        final likesText = '$likesCount $personOrpeople ${Strings.likedThis}';
        return Text(likesText);
      },
      loading: () {
        return const LoadingAnimationView();
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
    );
  }
}
