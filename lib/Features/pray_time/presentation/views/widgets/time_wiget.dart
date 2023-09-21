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
    required this.prayHour,
  }) : super(key: key);

  final String prayName;
  final String prayTime;
  final double timeNow;
  final double prayHour;
  @override
  Widget build(BuildContext context) {
    print("prayName  $prayName");
    print("prayTime  $prayTime");
    print("timeNow  $timeNow");
    print(prayHour - timeNow);
    double time = prayHour - timeNow;
    time < 0 ? time += 24 : time;
    print("time  $time");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prayTime,
          style: GoogleFonts.notoNastaliqUrdu(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: MyColors.darkBrown,
            ),
          ),
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.6,
          child: Slider(
            autofocus: true,
            value: time,
            min: 0,
            max: 24,
            onChanged: (value) {},
          ),
        ),
        Text(
          prayName,
          style: GoogleFonts.notoNastaliqUrdu(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: MyColors.darkBrown,
            ),
          ),
        ),
      ],
    );
  }
}
