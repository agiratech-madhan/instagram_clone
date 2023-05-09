// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:instagram_clone/state/comments/model/comment.dart';
import 'package:instagram_clone/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone/view/components/rich_two_parts_text.dart';

import '../animations/small_error_animation_view.dart';

class CompactCommentTile extends ConsumerWidget {
  const CompactCommentTile({required this.comment, Key? key}) : super(key: key);
  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (userInfoDetails) {
        return RichTwoPartsText(
            leftPart: userInfoDetails.displayName, rightPart: comment.comment);
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
