// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:instagram_clone/view/components/rich_text/base_text.dart';
import 'package:instagram_clone/view/components/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final TextStyle styleForAll;
  final Iterable<BaseText> texts;

  const RichTextWidget({
    Key? key,
    required this.styleForAll,
    required this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map(
          (e) {
            if (e is LinkText) {
              return TextSpan(
                  text: e.text,
                  style: styleForAll.merge(e.style),
                  recognizer: TapGestureRecognizer()..onTap = e.onTapped);
            } else {
              return TextSpan(
                text: e.text,
                style: styleForAll.merge(e.style),
              );
            }
          },
        ).toList(),
      ),
    );
  }
}
