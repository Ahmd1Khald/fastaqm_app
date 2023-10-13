import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../../../Core/constatnts/colors.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
  }) : super(key: key);

  String getHijryMonthName(int month) {
    String _monthName = "";
    if (month == 1) {
      _monthName = "المحرم";
    }
    if (month == 2) {
      _monthName = "صفر";
    }
    if (month == 3) {
      _monthName = "ربيع الأول";
    }
    if (month == 4) {
      _monthName = "ربيع الآخر";
    }
    if (month == 5) {
      _monthName = "جمادى الأولى";
    }
    if (month == 6) {
      _monthName = "جمادى الآخرة";
    }
    if (month == 7) {
      _monthName = "رجب";
    }
    if (month == 8) {
      _monthName = "شعبان";
    }
    if (month == 9) {
      _monthName = "رمضان";
    }
    if (month == 10) {
      _monthName = "شوال";
    }
    if (month == 11) {
      _monthName = "ذو القعدة";
    }
    if (month == 12) {
      _monthName = "ذو الحجة";
    }
    return _monthName;
  }

  String getHijryDayName(String day) {
    String _dayName = "";
    if (day == "Sunday") {
      _dayName = "الأحد";
    }
    if (day == "Saturday") {
      _dayName = "السبت";
    }
    if (day == "Monday") {
      _dayName = "الاثنين ";
    }
    if (day == "Wednesday") {
      _dayName = "الأربعاء";
    }
    if (day == "Tuesday") {
      _dayName = "الثلاثاء";
    }
    if (day == "Thursday") {
      _dayName = "الخميس";
    }
    if (day == "Friday") {
      _dayName = "الجمعة";
    }
    return _dayName;
  }

  @override
  Widget build(BuildContext context) {
    var _today = HijriCalendar.now();
    return Padding(
      padding: const EdgeInsets.only(top: 60.0, bottom: 25),
      child: Column(
        children: [
          Text(
            getHijryDayName(_today.dayWeName),
            style: GoogleFonts.noticiaText(
              textStyle: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.darkBrown,
              ),
            ),
          ),
          Text(
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            style: GoogleFonts.noticiaText(
              textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: MyColors.darkBrown,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_today.hYear}/",
                style: GoogleFonts.noticiaText(
                  textStyle: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.darkBrown,
                      textBaseline: TextBaseline.alphabetic),
                ),
              ),
              Text(
                "${getHijryMonthName(_today.hMonth)}/",
                style: GoogleFonts.noticiaText(
                  textStyle: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.darkBrown,
                      textBaseline: TextBaseline.alphabetic),
                ),
              ),
              Text(
                "${_today.hDay}",
                style: GoogleFonts.noticiaText(
                  textStyle: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: MyColors.darkBrown,
                      textBaseline: TextBaseline.alphabetic),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
