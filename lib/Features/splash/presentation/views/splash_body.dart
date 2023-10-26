import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:fastaqm_app/Features/layout/presentation/views/layout_body.dart';
import 'package:fastaqm_app/Features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  late Position? position;

  Future<void> getUserLocation() async {
    try {
      print("----0-----");
      CacheHelper.removeData(key: AppStrings.latKey);
      CacheHelper.removeData(key: AppStrings.longKey);

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        print("----1-----");
        permission = await Geolocator.requestPermission();
        CacheHelper.saveData(key: AppStrings.locationKey, value: false);
        navigateToHome();
      } else if (permission == LocationPermission.deniedForever) {
        print("----2-----");
        CacheHelper.saveData(key: AppStrings.locationKey, value: false);
        navigateToHome();
        throw PlatformException(
          code: 'PERMISSION_DENIED_FOREVER',
          message: 'Location permission denied forever',
        );
      } else {
        print("----3-----");
        // Check if the device is currently offline
        final bool isOffline = !await InternetConnectionChecker().hasConnection;
        if (isOffline) {
          // Handle offline scenario: No network connectivity
          print("----offline-----");
          CacheHelper.saveData(key: AppStrings.locationKey, value: false);
          navigateToHome();
        } else {
          // Device is online, attempt to get the location
          final Position position = await Geolocator.getCurrentPosition();
          print(position);
          CacheHelper.saveData(key: AppStrings.locationKey, value: true);
          CacheHelper.saveData(
              key: AppStrings.latKey, value: position.latitude);
          CacheHelper.saveData(
              key: AppStrings.longKey, value: position.longitude);
          navigateToHome();
          // Continue with additional logic or data processing here.
        }
      }
    } catch (e) {
      // Handle exceptions, including those related to network or location errors
      CacheHelper.saveData(key: AppStrings.locationKey, value: false);
      print("----error-----");
      navigateToHome();
      throw PlatformException(
        code: 'ERROR_GETTING_LOCATION',
        message: 'Error getting user location: $e',
      );
    }
  }

  // Future<String?> getCountryName(double latitude, double longitude) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(latitude, longitude);
  //
  //     if (placemarks.isNotEmpty) {
  //       return placemarks[0].country;
  //     } else {
  //       return null; // No placemark found
  //     }
  //   } catch (e) {
  //     print("Error getting country name: $e");
  //     return null; // Error occurred
  //   }
  // }

  @override
  void initState() {
    initSlidingAnimation();
    getUserLocation();
    print("lat => ${CacheHelper.getDate(key: AppStrings.latKey)}");
    print("long => ${CacheHelper.getDate(key: AppStrings.longKey)}");
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
      duration: const Duration(milliseconds: 1500),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      AppFunctions.pushAndRemove(
        context: context,
        screen: const LayoutScreen(),
      );
    });
  }
}
