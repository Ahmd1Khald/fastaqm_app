import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';

import '../constatnts/app_strings.dart';
import '../constatnts/colors.dart';
import '../helpers/cachehelper.dart';
import '../services/notification_service.dart';
import 'custom_SnackBar.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget(
      {Key? key, required this.notifyHelper, required this.cacheKey})
      : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
  final NotifyHelper notifyHelper;
  final String cacheKey;
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool? isSwitched;

  @override
  void initState() {
    isSwitched = CacheHelper.getDate(key: widget.cacheKey) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: isSwitched!,
        activeColor: MyColors.lightBrown,
        activeTrackColor: MyColors.darkBrown,
        onChanged: (value) {
          if (CacheHelper.getDate(key: AppStrings.latKey) != null &&
              CacheHelper.getDate(key: AppStrings.longKey) != null) {
            print("value => $value");
            isSwitched = value;
            CacheHelper.saveData(key: widget.cacheKey, value: isSwitched);
            setState(() {});

            if (CacheHelper.getDate(key: widget.cacheKey)) {
              //setup pray times
              final myCoordinates = Coordinates(
                CacheHelper.getDate(key: AppStrings.latKey),
                CacheHelper.getDate(key: AppStrings.longKey),
              ); // Replace with your own location lat, lng.
              final params = CalculationMethod.egyptian.getParameters();
              params.madhab = Madhab.shafi;
              final prayerTimes = PrayerTimes.today(myCoordinates, params);
              //pray times notify
              if (widget.cacheKey == "cache1") {
                widget.notifyHelper.scheduledNotification(
                  hour: prayerTimes.fajr.hour, //DateTime.now().hour,
                  minutes: prayerTimes.fajr.minute, //DateTime.now().minute + 1,
                  body: "الفجر",
                  id: 2,
                );
              } else if (widget.cacheKey == "cache2") {
                widget.notifyHelper.scheduledNotification(
                  hour: prayerTimes.dhuhr.hour,
                  minutes: prayerTimes.dhuhr.minute,
                  body: "الظهر",
                  id: 3,
                );
              } else if (widget.cacheKey == "cache3") {
                widget.notifyHelper.scheduledNotification(
                  hour: prayerTimes.asr.hour,
                  minutes: prayerTimes.asr.minute,
                  body: "العصر",
                  id: 4,
                );
              } else if (widget.cacheKey == "cache4") {
                widget.notifyHelper.scheduledNotification(
                  hour: prayerTimes.maghrib.hour,
                  minutes: prayerTimes.maghrib.minute,
                  body: "المغرب",
                  id: 5,
                );
              } else if (widget.cacheKey == "cache5") {
                widget.notifyHelper.scheduledNotification(
                  hour: prayerTimes.isha.hour,
                  minutes: prayerTimes.isha.minute,
                  body: "العشاء",
                  id: 6,
                );
              }

              widget.notifyHelper.azkarNotification(
                hour: prayerTimes.fajr.hour,
                minutes: prayerTimes.fajr.minute + 50,
                body: "ابدأ يومك بأذكار الصباح",
                title: 'الصباح',
                id: 0,
              );
              widget.notifyHelper.azkarNotification(
                hour: prayerTimes.asr.hour,
                minutes: prayerTimes.asr.minute + 60,
                body: "اختم يومك بأذكار المساء",
                title: 'المساء',
                id: 1,
              );
            } else {
              if (widget.cacheKey == "cache1") {
                widget.notifyHelper.cancelNotifications(id: 2);
              } else if (widget.cacheKey == "cache2") {
                widget.notifyHelper.cancelNotifications(id: 3);
              } else if (widget.cacheKey == "cache3") {
                widget.notifyHelper.cancelNotifications(id: 4);
              } else if (widget.cacheKey == "cache4") {
                widget.notifyHelper.cancelNotifications(id: 5);
              } else if (widget.cacheKey == "cache5") {
                widget.notifyHelper.cancelNotifications(id: 6);
              }
            }
          } else {
            customSnackBar(
                context: context, title: 'قم بالسماح بأخذ موقعك أولا');
          }
        });
  }
}
