import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.prayName,
    required this.prayTime,
  });

  final String prayName;
  final String prayTime;
  @override
  Widget build(BuildContext context) {
    print(prayName);
    print("${prayTime.split(':').first} --- ${DateTime.now().hour}");
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // CircleAvatar(
        //   radius: 47.5.sp,
        //   backgroundColor: MyColors.darkBrown,
        // ),

        CircleAvatar(
          radius: 42.8.sp,
          backgroundColor: MyColors.creamColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                prayName,
                textAlign: TextAlign.right,
                style: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 18.sp,
                  color: MyColors.babyBrown,
                ),
              ),
              Text(
                prayTime,
                textAlign: TextAlign.right,
                style: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.25,
          height: AppVariables.appSize(context).width * 0.25,
          child: CircularProgressIndicator(
            backgroundColor: MyColors.lightBrown,
            value: (DateTime.now().hour / int.parse(prayTime.split(':').first)),
            color: MyColors.darkBrown,
          ),
        ),
      ],
    );
  }
}
