import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:fastaqm_app/Core/widgets/custom_loading.dart';
import 'package:fastaqm_app/Features/qibla/presentation/views/widgets/qiblah_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../../../Core/widgets/custom_SnackBar.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      final bool isOffline = !await InternetConnectionChecker().hasConnection;

      if (isOffline) {
        CacheHelper.saveData(key: AppStrings.locationKey, value: false);
        customSnackBar(context: context, title: 'لا يوجد انترنيت');
      } else {
        var status = await Permission.locationWhenInUse.request();

        if (status.isGranted) {
          // Attempt to retrieve the last known location
          Position? position = await Geolocator.getLastKnownPosition();

          // If no last known location, get the current location
          position ??= await Geolocator.getCurrentPosition();

          CacheHelper.saveData(key: AppStrings.locationKey, value: true);
          CacheHelper.saveData(
              key: AppStrings.latKey, value: position.latitude);
          CacheHelper.saveData(
              key: AppStrings.longKey, value: position.longitude);
        } else {
          CacheHelper.saveData(key: AppStrings.locationKey, value: false);
          customSnackBar(
              context: context, title: 'قم بالسماح بأخذ موقعك من الإعدادات');
        }
      }
    } catch (e) {
      CacheHelper.saveData(key: AppStrings.locationKey, value: false);
      throw PlatformException(
        code: 'ERROR_GETTING_LOCATION',
        message: 'Error getting user location: $e',
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CustomLoadingPage();
    }

    if (CacheHelper.getDate(key: AppStrings.locationKey) == true) {
      return const QiblahWidget();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomErrorContainer(title: 'قم بتفعيل القبلة'),
        const SizedBox(height: 45),
        MaterialButton(
          color: MyColors.darkBrown,
          onPressed: () async {
            await getUserLocation();
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
    );
  }
}
