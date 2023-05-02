// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

import 'models/lottie_animation.dart';

class LottieAnimationView extends StatelessWidget {
  const LottieAnimationView({
    Key? key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  }) : super(key: key);
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;
  @override
  Widget build(BuildContext context) =>
      Lottie.asset(animation.fullPath, reverse: reverse, repeat: repeat);
}
