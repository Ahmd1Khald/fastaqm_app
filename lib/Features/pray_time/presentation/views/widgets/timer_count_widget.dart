import 'dart:async';

import 'package:fastaqm_app/Features/pray_time/presentation/controller/pray_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class TimerCountWidget extends StatefulWidget {
  const TimerCountWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<TimerCountWidget> createState() => _TimerCountWidgetState();
  final PrayTimeCubit cubit;
}

class _TimerCountWidgetState
    extends State<TimerCountWidget> /* with AutomaticKeepAliveClientMixin*/ {
  // @override
  // bool get wantKeepAlive => true;
  String getPrayArabicName(String pray) {
    String prayName = "";
    if (pray == "fajr") {
      prayName = "الفجر";
    }
    if (pray == "sunrise") {
      prayName = "الشروق";
    }
    if (pray == "dhuhr") {
      prayName = "الظهر";
    }
    if (pray == "asr") {
      prayName = "العصر";
    }
    if (pray == "maghrib") {
      prayName = "المغرب";
    }
    if (pray == "isha") {
      prayName = "العشاء";
    }

    return prayName;
  }

  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  late Timer _timer;

  void calculateTimeRemain() {
    // _hours = DateTime.now().hour - widget.cubit.timeForNextPray!.hour;
    // _minutes = DateTime.now().minute - widget.cubit.timeForNextPray!.minute;
    // _seconds = DateTime.now().second - widget.cubit.timeForNextPray!.second;
    //
    // print("_hours");
    // print(_hours);
    // print("_minutes");
    // print(_minutes);
    // print("_seconds");
    // print(_seconds);
    //
    // if (_hours < 0) _hours *= -1;
    // if (_minutes < 0) _minutes *= -1;
    // if (_seconds < 0) _seconds *= -1;

    // Define two times as strings (HH:MM:SS)
    String time1 = DateTime.now().toString();
    String time2 = widget.cubit.timeForNextPray!.toString();

    print("time1 $time1");
    print("time2 $time2");

    // Convert the time strings to DateTime objects
    DateTime dateTime1 = DateTime.parse(time1);
    DateTime dateTime2 = DateTime.parse(time2);

    // Calculate the difference between the two times
    Duration difference = dateTime1.difference(dateTime2);

    // Extract hours, minutes, and seconds from the duration
    _hours = difference.inHours;
    _minutes = (difference.inMinutes - _hours * 60);
    _seconds = (difference.inSeconds - _hours * 3600 - _minutes * 60);

    if (_hours < 0) _hours *= -1;
    if (_minutes < 0) _minutes *= -1;
    if (_seconds < 0) _seconds *= -1;

    print(
        "Time Difference: $_hours hours, $_minutes minutes, $_seconds seconds");
  }

  bool lock = false;

  @override
  void initState() {
    super.initState();
    calculateTimeRemain();
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_hours == 0 && _minutes == 0 && _seconds == 0) {
          _timer.cancel();
          // Timer has finished, you can perform an action here.
        } else if (_minutes == 0 && _seconds == 0) {
          _hours--;
          _minutes = 59;
          _seconds = 59;
        } else if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _seconds--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              radius: 60.sp,
              backgroundColor: MyColors.darkBrown,
            ),
            CircleAvatar(
              radius: 55.sp,
              child: Text(
                getPrayArabicName(widget.cubit.nextPray!.name),
                textAlign: TextAlign.right,
                style: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 22.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 25.w,
        ),
        Column(
          children: [
            Text(
              'الصلاة القادمة',
              textAlign: TextAlign.right,
              style: GoogleFonts.noticiaText(
                fontWeight: FontWeight.w400,
                fontSize: 28.sp,
                color: MyColors.darkBrown,
              ),
            ),
            Row(
              children: [
                Text(
                  '$_hours:$_minutes:$_seconds',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.noticiaText(
                    fontWeight: FontWeight.w400,
                    fontSize: 25.sp,
                    color: MyColors.darkBrown,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Image.asset(
                  AssetsManager.timerIcon,
                  width: AppVariables.appSize(context).width * 0.14,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
