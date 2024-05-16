import 'package:fastaqm_app/Features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../Core/constatnts/app_functions.dart';
import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/assets_manager.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../../layout/presentation/views/layout_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    initSlidingAnimation();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AssetsManager.appLogo,
            height: AppVariables.appSize(context).width * 0.5,
          ),
          SlidingText(slidingAnimation: slidingAnimation),
        ],
      ),
    );
  }

  Future initSlidingAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
            .animate(animationController);

    animationController
        .forward()
        .then((value) => getLocationAndNavigate(context));
  }

  void getLocationAndNavigate(context) async {
    final bool hasLocationData =
        CacheHelper.getDate(key: AppStrings.locationKey) ?? false;
    if (!hasLocationData) {
      // Location data is not cached, request location
      final bool locationPermissionGranted = await requestLocationPermission();
      if (locationPermissionGranted) {
        await getLocation(context);
      } else {
        navigateToHome(context);
      }
    } else {
      // Location data is already cached, navigate directly
      navigateToHome(context);
    }
  }

  Future<bool> requestLocationPermission() async {
    try {
      final LocationPermission permission =
          await Geolocator.requestPermission();
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      return false;
    }
  }

  Future<void> getLocation(context) async {
    try {
      final Position position = await Geolocator.getCurrentPosition();
      // Cache location data
      CacheHelper.saveData(key: AppStrings.locationKey, value: true);
      CacheHelper.saveData(key: AppStrings.latKey, value: position.latitude);
      CacheHelper.saveData(key: AppStrings.longKey, value: position.longitude);
    } catch (e) {
      // Handle location-related errors
    } finally {
      navigateToHome(context);
    }
  }

  void navigateToHome(context) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      AppFunctions.pushAndRemove(
        context: context,
        screen: const LayoutScreen(),
      );
    });
  }
}
