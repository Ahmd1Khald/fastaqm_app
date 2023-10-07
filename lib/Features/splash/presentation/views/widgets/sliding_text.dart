import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            child: SizedBox(
              width: AppVariables.appSize(context).width * 0.99,
              child: Text(
                AppStrings.slidingSplashTest,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32.sp, color: MyColors.babyBrown),
              ),
            ),
          );
        });
  }
}
