import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/view/components/animations/empty_content_with_text_animation_view.dart';

import '../../../state/posts/providers/all_posts_provider.dart';
import '../../components/animations/error_animation_view.dart';
import '../../components/animations/loading_animation_view.dart';
import '../../components/constants/strings.dart';
import '../../components/post/post_grid_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        final value = ref.refresh(allPostsProvider);
        return Future.delayed(Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
              text: Strings.noPostsAvailable,
            );
          } else {
            return PostsGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
    // return Container();
  }
}
