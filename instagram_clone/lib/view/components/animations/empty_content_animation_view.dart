import 'lottie_animation_view.dart';
import 'models/lottie_animation.dart';

class EmptyContentAnimationView extends LottieAnimationView {
  const EmptyContentAnimationView({super.key})
      : super(animation: LottieAnimation.empty);
}
