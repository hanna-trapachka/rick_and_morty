import 'package:flutter/widgets.dart';

import '../../assets/assets.gen.dart';

class AppLoadingAnimation extends StatelessWidget {
  const AppLoadingAnimation({this.size = 100, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Assets.animations.rickDrinking.lottie(fit: BoxFit.fitHeight),
    );
  }
}
