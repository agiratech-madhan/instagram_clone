// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:instagram_clone/view/components/animations/empty_content_animation_view.dart';

import 'lottie_animation_view.dart';
import 'models/lottie_animation.dart';

// class EmptyContentWithTextAnimationView extends LottieAnimationView {
//   const EmptyContentWithTextAnimationView({super.key})
//       : super(animation: LottieAnimation.empty);
// }
class EmptyContentWithTextAnimationView extends StatelessWidget {
  final String text;

  const EmptyContentWithTextAnimationView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white54,
                  ),
            ),
          ),
          EmptyContentAnimationView()
        ],
      ),
    );
  }
}
