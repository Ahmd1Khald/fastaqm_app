import 'package:fastaqm_app/Features/layout/presentation/views/layout_body.dart';
import 'package:fastaqm_app/Features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';

import '../../../../Core/constatnts/app_functions.dart';
import '../../../../Core/constatnts/assets_manager.dart';
import '../../../../Core/constatnts/variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AssetsManager.appLogo,
            height: AppVariables.appSize(context).width * 0.5,
          ),
          // const SizedBox(
          //   height: 4,
          // ),
          SlidingText(slidingAnimation: slidingAnimation),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        AppFunctions.pushAndRemove(
          context: context,
          screen: const LayoutScreen(),
        );
        //GoRouter.of(context).push(AppRouter.kHomeView);
      },
    );
  }
}
