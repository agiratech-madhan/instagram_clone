// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:instagram_clone/state/comments/model/comment.dart';
import 'package:instagram_clone/view/components/coments/compact_comment_tile.dart';

class CompactCommentColumn extends StatelessWidget {
  const CompactCommentColumn({
    Key? key,
    required this.comments,
  }) : super(key: key);
  final Iterable<Comment> comments;
  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments
              .map(
                (comment) => CompactCommentTile(
                  comment: comment,
                ),
              )
              .toList(),
        ),
      );
    }
  }
}
