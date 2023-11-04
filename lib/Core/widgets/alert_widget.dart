import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';

import '../constatnts/app_strings.dart';
import '../constatnts/colors.dart';
import '../helpers/cachehelper.dart';
import '../services/notification_service.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({Key? key, required this.notifyHelper}) : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
  final NotifyHelper notifyHelper;
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool isSwitched = CacheHelper.getDate(key: 'isSwitched') ?? false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: isSwitched,
        activeColor: MyColors.lightBrown,
        activeTrackColor: MyColors.darkBrown,
        onChanged: (value) {
          print("value => $value");
          isSwitched = value;
          CacheHelper.saveData(key: "isSwitched", value: isSwitched);
          setState(() {});

          if (CacheHelper.getDate(key: 'isSwitched')) {
            //setup pray times
            final myCoordinates = Coordinates(
              CacheHelper.getDate(key: AppStrings.latKey),
              CacheHelper.getDate(key: AppStrings.longKey),
            ); // Replace with your own location lat, lng.
            final params = CalculationMethod.egyptian.getParameters();
            params.madhab = Madhab.shafi;
            final prayerTimes = PrayerTimes.today(myCoordinates, params);
            //pray times notify
            widget.notifyHelper.scheduledNotification(
              hour: prayerTimes.fajr.hour,
              minutes: prayerTimes.fajr.minute,
              body: "الفجر",
            );
            widget.notifyHelper.scheduledNotification(
              hour: prayerTimes.dhuhr.hour,
              minutes: prayerTimes.dhuhr.minute,
              body: "الظهر",
            );
            widget.notifyHelper.scheduledNotification(
              hour: prayerTimes.asr.hour,
              minutes: prayerTimes.asr.minute,
              body: "العصر",
            );
            widget.notifyHelper.scheduledNotification(
              hour: prayerTimes.maghrib.hour,
              minutes: prayerTimes.maghrib.minute,
              body: "المغرب",
            );
            widget.notifyHelper.scheduledNotification(
              hour: prayerTimes.isha.hour,
              minutes: prayerTimes.isha.minute,
              body: "العشاء",
            );
          } else {
            widget.notifyHelper.cancelNotifications();
          }
        });
  }
}
