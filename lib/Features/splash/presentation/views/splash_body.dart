import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:fastaqm_app/Features/layout/presentation/views/layout_body.dart';
import 'package:fastaqm_app/Features/splash/presentation/views/widgets/sliding_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<Position> getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        CacheHelper.saveData(key: AppStrings.countryNameKey, value: "egypt");
        if (permission == LocationPermission.denied) {
          throw PlatformException(
            code: 'PERMISSION_DENIED',
            message: 'Location permission denied',
          );
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw PlatformException(
          code: 'PERMISSION_DENIED_FOREVER',
          message: 'Location permission denied forever',
        );
      }
      final Position position = await Geolocator.getCurrentPosition();
      print(position);
      return position;
    } catch (e) {
      throw PlatformException(
        code: 'ERROR_GETTING_LOCATION',
        message: 'Error getting user location: $e',
      );
    }
  }

  Future<String?> getCountryName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        return placemarks[0].country;
      } else {
        return null; // No placemark found
      }
    } catch (e) {
      print("Error getting country name: $e");
      return null; // Error occurred
    }
  }

  @override
  void initState() {
    initSlidingAnimation();
    getUserLocation().then((value) async {
      await getCountryName(value.latitude, value.longitude).then((value) {
        CacheHelper.saveData(
            key: AppStrings.countryNameKey, value: value ?? "egypt");
        print(CacheHelper.getDate(key: AppStrings.countryNameKey));
        navigateToHome();
      });
    }).catchError((error) {
      //initSlidingAnimation();
      navigateToHome();
    });
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
    Future.delayed(const Duration(seconds: 2)).then((value) {
      AppFunctions.pushAndRemove(
        context: context,
        screen: const LayoutScreen(),
      );
    });
  }
}
