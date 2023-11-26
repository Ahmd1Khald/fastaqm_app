import 'package:adhan/adhan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Features/qibla/presentation/views/qibla_body.dart';
import 'package:flutter/material.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../../../Core/services/notification_service.dart';
import '../../../../Core/widgets/App_name.dart';
import '../../../home/presentation/views/home_body.dart';
import '../../../saves/presentation/views/saves_body.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> screens = [
    const SavesScreen(),
    const QiblaScreen(),
    const HomeScreen(),
  ];
  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late NotifyHelper notifyHelper;

  Future<void> _pauseAzan() async {
    try {
      // Load the audio file from assets
      await AppVariables.assetsAudioPlayer.stop();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();

    if (CacheHelper.getDate(key: AppStrings.latKey) != null &&
        CacheHelper.getDate(key: AppStrings.longKey) != null) {
      final myCoordinates = Coordinates(
        CacheHelper.getDate(key: AppStrings.latKey),
        CacheHelper.getDate(key: AppStrings.longKey),
      );
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      notifyHelper.azkarNotification(
        hour: prayerTimes.fajr.hour,
        minutes: prayerTimes.fajr.minute + 40,
        body: "ابدأ يومك بأذكار الصباح",
        title: 'الصباح',
        id: 0,
      );
      notifyHelper.azkarNotification(
        hour: prayerTimes.asr.hour,
        minutes: prayerTimes.asr.minute + 60,
        body: "اختم يومك بأذكار المساء",
        title: 'المساء',
        id: 1,
      );

      notifyHelper.fridayNotification(
        hour: prayerTimes.dhuhr.hour + 1,
        minutes: prayerTimes.dhuhr.minute,
        body:
            "{إِنَّ اللَّهَ وَمَلَائِكَتَهُ يُصَلُّونَ عَلَى النَّبِيِّ ۚ يَا أَيُّهَا الَّذِينَ آمَنُوا صَلُّوا عَلَيْهِ وَسَلِّمُوا تَسْلِيمًا}",
        title: 'فاستقم',
        id: 8,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double navBarIconSize = 40;
    return Scaffold(
      bottomNavigationBar: buildCurvedNavigationBar(navBarIconSize),
      appBar: AppBar(
        title: const Row(
          children: [
            // InkWell(
            //   onTap: () async {
            //     showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12)),
            //         content: SizedBox(
            //           height: AppVariables.appSize(context).width * 1.3,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Image.asset(
            //                 AssetsManager.azanIcon,
            //                 width: 80.sp,
            //               ),
            //               SizedBox(
            //                 height:
            //                     AppVariables.appSize(context).height * 0.013,
            //               ),
            //               Text(
            //                 'هل تود تفعيل الآذان؟',
            //                 style: GoogleFonts.noticiaText(
            //                   color: MyColors.darkBrown,
            //                   fontSize: 20.sp,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height:
            //                     AppVariables.appSize(context).height * 0.013,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SwitchWidget(
            //                       notifyHelper: notifyHelper,
            //                       cacheKey: 'cache1'),
            //                   Text(
            //                     'الفجر',
            //                     style: GoogleFonts.noticiaText(
            //                       color: MyColors.darkBrown,
            //                       fontSize: 18.sp,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SwitchWidget(
            //                       notifyHelper: notifyHelper,
            //                       cacheKey: 'cache2'),
            //                   Text(
            //                     'الظهر',
            //                     style: GoogleFonts.noticiaText(
            //                       color: MyColors.darkBrown,
            //                       fontSize: 18.sp,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SwitchWidget(
            //                       notifyHelper: notifyHelper,
            //                       cacheKey: 'cache5'),
            //                   Text(
            //                     'العصر',
            //                     style: GoogleFonts.noticiaText(
            //                       color: MyColors.darkBrown,
            //                       fontSize: 18.sp,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SwitchWidget(
            //                       notifyHelper: notifyHelper,
            //                       cacheKey: 'cache4'),
            //                   Text(
            //                     'المغرب',
            //                     style: GoogleFonts.noticiaText(
            //                       color: MyColors.darkBrown,
            //                       fontSize: 18.sp,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   SwitchWidget(
            //                       notifyHelper: notifyHelper,
            //                       cacheKey: 'cache3'),
            //                   Text(
            //                     'العشاء',
            //                     style: GoogleFonts.noticiaText(
            //                       color: MyColors.darkBrown,
            //                       fontSize: 18.sp,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               const AzanListening(),
            //               const Spacer(),
            //               ElevatedButton(
            //                 onPressed: () {
            //                   _pauseAzan();
            //                   setState(() {});
            //                   Navigator.pop(context);
            //                 },
            //                 child: Text(
            //                   "تم",
            //                   style: GoogleFonts.noticiaText(
            //                     color: MyColors.darkBrown,
            //                     fontSize: 18.sp,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   child: SizedBox(
            //     width: AppVariables.appSize(context).width * 0.25,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Shimmer.fromColors(
            //           period: const Duration(seconds: 2),
            //           baseColor: MyColors.babyBrown,
            //           highlightColor: MyColors.darkBrown,
            //           child: Icon(
            //             CacheHelper.getDate(key: 'cache1') == true ||
            //                     CacheHelper.getDate(key: 'cache2') == true ||
            //                     CacheHelper.getDate(key: 'cache3') == true ||
            //                     CacheHelper.getDate(key: 'cache4') == true ||
            //                     CacheHelper.getDate(key: 'cache5') == true
            //                 ? Icons.notifications_active
            //                 : Icons.notifications,
            //             color: MyColors.darkBrown,
            //             size: 30.sp,
            //           ),
            //         ),
            //         Text(
            //           "الآذان",
            //           style: GoogleFonts.noticiaText(
            //             color: MyColors.darkBrown,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Spacer(),
            AppName(),
          ],
        ),
      ),
      body: screens[_page],
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar(double navBarIconSize) {
    return CurvedNavigationBar(
      index: _page,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: MyColors.darkBrown,
      key: _bottomNavigationKey,
      //height: AppVariables.appSize(context).width * 0.15,
      items: <Widget>[
        Image.asset(
          AssetsManager.saveIcon,
          width: navBarIconSize,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Image.asset(
          AssetsManager.qiblaBottumIcon,
          width: navBarIconSize,
          //color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Image.asset(
          AssetsManager.homeIcon,
          width: navBarIconSize + 13,
          fit: BoxFit.cover,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ],
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }
}
