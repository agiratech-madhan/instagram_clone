import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/posts/providers/post_by_search_term_provider.dart';
import 'package:instagram_clone/view/components/animations/empty_content_with_text_animation_view.dart';
import 'package:instagram_clone/view/components/post/post_grid_view.dart';
import 'package:instagram_clone/view/components/post/post_sliver_grid_view.dart';

import 'animations/data_not_found_animation_view.dart';
import 'animations/error_animation_view.dart';
import 'constants/strings.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;

  const SearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentWithTextAnimationView(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }

    final posts = ref.watch(
      postBysearchTermprovider(
        searchTerm,
      ),
    );

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationView(),
          );
        } else {
          return PostsSliverGridView(posts: posts);
        }
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
          child: ErrorAnimationView(),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
