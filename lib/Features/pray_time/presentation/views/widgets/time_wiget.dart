import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.prayName,
    required this.timeNow,
    required this.prayTime,
  }) : super(key: key);

  final String prayName;
  final String prayTime;
  final double timeNow;
  @override
  Widget build(BuildContext context) {
    String ss = prayTime;
    int prayHour = int.parse(ss.split(":").first);
    print("prayName  $prayName");
    print("prayTime  $prayTime");
    print("timeNow  $timeNow");
    print(prayHour - timeNow);
    double time = timeNow - prayHour;
    time < 0 ? time += 24 : time;
    print("time  $time");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: AppVariables.appSize(context).width * 0.19,
          child: Text(
            prayTime,
            style: GoogleFonts.notoNastaliqUrdu(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: MyColors.darkBrown,
              ),
            ),
          ),
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.55,
          child: Slider(
            //secondaryActiveColor: MyColors.creamColor,
            activeColor: MyColors.darkBrown,
            //inactiveColor: MyColors.lightBrown,
            autofocus: true,
            value: time,
            min: 0,
            max: 24,
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.18,
          child: Text(
            prayName,
            style: GoogleFonts.notoNastaliqUrdu(
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: MyColors.darkBrown,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
