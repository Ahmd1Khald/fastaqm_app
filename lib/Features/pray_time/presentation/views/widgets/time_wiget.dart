import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    Key? key,
    required this.prayName,
    required this.prayTime,
  }) : super(key: key);

  final String prayName;
  final String prayTime;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CircleAvatar(
          radius: 47.5.sp,
          backgroundColor: MyColors.darkBrown,
        ),
        CircleAvatar(
          radius: 42.5.sp,
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
      ],
    );
  }
}
