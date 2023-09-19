import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/app_strings.dart';
import '../../../../../Core/constatnts/colors.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    Key? key,
    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child: const Text(
              AppStrings.slidingSplashTest,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, color: MyColors.babyBrown),
            ),
          );
        });
  }
}
