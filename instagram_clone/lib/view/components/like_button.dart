// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/provider/user_id_provier.dart';
import 'package:instagram_clone/state/likes/models/likes_dislikes_request.dart';
import 'package:instagram_clone/state/likes/providers/has_liked_post_provider.dart';
import 'package:instagram_clone/state/likes/providers/like_dislike_post_provider.dart';

import 'package:instagram_clone/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone/view/components/animations/small_error_animation_view.dart';

class LikeButton extends ConsumerWidget {
  const LikeButton({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));
    return hasLiked.when(
        data: (liked) {
          return IconButton(
              onPressed: () {
                final userId = ref.read(userIdProvider);

                if (userId == null) {
                  return;
                }
                final likeRequest =
                    LikeDislikeRequest(postId: postId, uerId: userId);
                ref.read(likeDislikeProvider(likeRequest));
              },
              icon: Icon(liked ? Icons.favorite : Icons.favorite_border));
        },
        error: (error, stracktrance) {
          return const SmallErrorAnimationView();
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
