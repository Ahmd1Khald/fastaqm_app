import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/constant.dart';
import '../../../ahadith/presentation/views/ahadith_body.dart';
import '../../../azkar/presentation/views/azkar_body.dart';
import '../../../bakiat/presentation/views/bakiat_body.dart';
import '../../../duaa/presentation/views/duaa_body.dart';
import '../../../pray_time/presentation/views/pray_time_body.dart';
import '../../../quran/presentation/views/quran_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    Future.wait({readJson()});
    notificationService.initializeNotifications();
    //notify when app open and online
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   if (message.notification != null) {
    //     print("------------------------");
    //     print(message.notification!.title);
    //     print("-------------------------");
    //
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text("${message.notification!.body}",
    //             textAlign: TextAlign.right),
    //         backgroundColor: MyColors.darkBrown,
    //         behavior: SnackBarBehavior.floating,
    //       ),
    //     );
    //   }
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   if (message.data['type'] == 'pray') {
    //     AppFunctions.pushTo(context: context, screen: const PrayTimeScreen());
    //   } else if (message.data['type'] == 'azkar') {
    //     AppFunctions.pushTo(context: context, screen: const AzkarScreen());
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // if (CacheHelper.getDate(key: AppStrings.locationKey) == true)
          //   const Expanded(child: QiblahScreen()),
          // if (CacheHelper.getDate(key: AppStrings.locationKey) == false)
          //   const CustomErrorContainer(
          //     title: "قم بتفعيل الموقع\nلاظهار القبلة",
          //   ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customItem(
                context: context,
                image: AssetsManager.masjedIcon,
                text: "مواقيت الصلاة",
                func: () {
                  notificationService.scheduleNotification(
                      title: "الصلاة عماد الدين", body: "حان موعد صلاة المغرب");
                  AppFunctions.pushTo(
                    context: context,
                    screen: const PrayTimeScreen(),
                  );
                },
              ),
              customItem(
                context: context,
                image: AssetsManager.hadithLogo,
                text: "أحاديث",
                func: () {
                  AppFunctions.pushTo(
                    context: context,
                    screen: const AhadithScreen(),
                  );
                },
              ),
              customItem(
                context: context,
                image: AssetsManager.quranIcon,
                text: "قرآن",
                func: () {
                  AppFunctions.pushTo(
                    context: context,
                    screen: const QuranScreen(),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const QuranScreen()),
                  // );
                },
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customItem(
                context: context,
                image: AssetsManager.duaaLogo,
                text: "أدعية وظيفية",
                func: () {
                  AppFunctions.pushTo(
                    context: context,
                    screen: const DuaaScreen(),
                  );
                },
              ),
              customItem(
                context: context,
                image: AssetsManager.bakiatIcon,
                text: "أذكار",
                func: () {
                  AppFunctions.pushTo(
                    context: context,
                    screen: const AzkarScreen(),
                  );
                },
              ),
              customItem(
                context: context,
                image: AssetsManager.azkarIcon,
                text: "الباقيات الصالحات",
                func: () {
                  AppFunctions.pushTo(
                    context: context,
                    screen: const BakiatScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column customItem({
    required BuildContext context,
    required String image,
    required String text,
    required VoidCallback func,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          height: AppVariables.appSize(context).width * 0.2,
          minWidth: AppVariables.appSize(context).width * 0.2,
          onPressed: func,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          splashColor: MyColors.lightBrown,
          color: MyColors.darkBrown,
          child: Center(
            child: Image.asset(
              image,
              width: AppVariables.appSize(context).width * 0.15,
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: GoogleFonts.noticiaText(
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}
