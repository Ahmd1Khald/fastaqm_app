import 'package:adhan/adhan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Features/qibla/presentation/views/qibla_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../../../Core/services/notification_service.dart';
import '../../../../Core/widgets/App_name.dart';
import '../../../../Core/widgets/alert_widget.dart';
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
  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    if (CacheHelper.getDate(key: AppStrings.latKey) != null &&
        CacheHelper.getDate(key: AppStrings.longKey) != null) {
      final myCoordinates = Coordinates(
        CacheHelper.getDate(key: AppStrings.latKey),
        CacheHelper.getDate(key: AppStrings.longKey),
      ); // Replace with your own location lat, lng.
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      //pray times notify
      notifyHelper.azkarNotification(
        hour: prayerTimes.sunrise.hour,
        minutes: prayerTimes.sunrise.minute,
        body: "ابدأ يومك بأذكار الصباح",
        title: 'الصباح',
      );
      notifyHelper.azkarNotification(
        hour: prayerTimes.maghrib.hour,
        minutes: prayerTimes.maghrib.minute + 15,
        body: "اختم يومك بأذكار المساء",
        title: 'المساء',
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
        title: const AppName(),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: MyColors.babyBrown,
              highlightColor: MyColors.darkBrown,
              child: IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      content: SizedBox(
                        height: AppVariables.appSize(context).height * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsManager.azanIcon,
                              width: 80.sp,
                            ),
                            SizedBox(
                              height:
                                  AppVariables.appSize(context).height * 0.013,
                            ),
                            Text(
                              'هل تود تفعيل الآذان؟',
                              style: GoogleFonts.noticiaText(
                                color: MyColors.darkBrown,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              height:
                                  AppVariables.appSize(context).height * 0.013,
                            ),
                            SwitchWidget(notifyHelper: notifyHelper),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "تم",
                                    style: GoogleFonts.noticiaText(
                                      color: MyColors.darkBrown,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  CacheHelper.getDate(key: 'isSwitched') == true
                      ? Icons.notifications_active
                      : CacheHelper.getDate(key: 'isSwitched') == false
                          ? Icons.notifications
                          : Icons.notifications,
                  color: MyColors.darkBrown,
                  size: 32.sp,
                ),
              ),
            ),
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
