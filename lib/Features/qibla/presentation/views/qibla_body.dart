import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:fastaqm_app/Core/widgets/custom_loading.dart';
import 'package:fastaqm_app/Features/qibla/presentation/views/widgets/qiblah_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/helpers/cachehelper.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  Future<Position> getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          CacheHelper.saveData(key: AppStrings.locationKey, value: false);
          throw PlatformException(
            code: 'PERMISSION_DENIED',
            message: 'Location permission denied',
          );
        }
      }
      if (permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        print(permission.toString());
        CacheHelper.saveData(key: AppStrings.locationKey, value: false);
        throw PlatformException(
          code: 'PERMISSION_DENIED_FOREVER',
          message: 'Location permission denied forever',
        );
      }
      final Position position = await Geolocator.getCurrentPosition();
      print(position);

      return position;
    } catch (e) {
      CacheHelper.saveData(key: AppStrings.locationKey, value: false);
      print(e.toString());
      throw PlatformException(
        code: 'ERROR_GETTING_LOCATION',
        message: 'Error getting user location: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (CacheHelper.getDate(key: AppStrings.locationKey) == true) {
      return const QiblahWidget();
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomErrorContainer(title: 'قم بتفعيل الموقع'),
          const SizedBox(
            height: 45,
          ),
          MaterialButton(
            color: MyColors.darkBrown,
            onPressed: () async {
              const CustomLoadingPage();
              await getUserLocation().then((value) {
                CacheHelper.saveData(key: AppStrings.locationKey, value: true);
                setState(() {});
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            splashColor: MyColors.lightBrown,
            elevation: 5,
            height: AppVariables.appSize(context).width * 0.15,
            child: Text(
              "تفعيل الموقع",
              style: GoogleFonts.noticiaText(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
