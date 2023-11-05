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

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../../../Core/widgets/custom_SnackBar.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  //var location;
  Future<void> getUserLocation() async {
    try {
      // Check if the device is currently offline
      final bool isOffline = !await InternetConnectionChecker().hasConnection;

      if (isOffline) {
        // Handle offline scenario: No network connectivity
        print("----offline-----");
        CacheHelper.saveData(key: AppStrings.locationKey, value: false);
        customSnackBar(context: context, title: 'لا يوجد انترنيت');
      } else {
        // Device is online, attempt to get the location
        final Position position = await Geolocator.getCurrentPosition();
        print(position);
        CacheHelper.saveData(key: AppStrings.locationKey, value: true);
        CacheHelper.saveData(key: AppStrings.latKey, value: position.latitude);
        CacheHelper.saveData(
            key: AppStrings.longKey, value: position.longitude);
        // Continue with additional logic or data processing here.
      }
    } catch (e) {
      // Handle exceptions, including those related to network or location errors
      CacheHelper.saveData(key: AppStrings.locationKey, value: false);
      print("----error-----");
      throw PlatformException(
        code: 'ERROR_GETTING_LOCATION',
        message: 'Error getting user location: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (CacheHelper.getDate(key: AppStrings.locationKey) ==
            true /*&&
        location != null*/
        ) {
      return const QiblahWidget();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomErrorContainer(title: 'قم بتفعيل القبلة'),
        const SizedBox(
          height: 45,
        ),
        MaterialButton(
          color: MyColors.darkBrown,
          onPressed: () async {
            const CustomLoadingPage();
            await getUserLocation();
            setState(() {});
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
