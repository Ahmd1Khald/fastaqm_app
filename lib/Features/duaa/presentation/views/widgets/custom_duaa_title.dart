import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomDuaaTitle extends StatelessWidget {
  const CustomDuaaTitle({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppVariables.appSize(context).width * 0.8,
        height: AppVariables.appSize(context).width * 0.15,
        decoration: BoxDecoration(
          color: MyColors.darkBrown,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoNastaliqUrdu(
            color: MyColors.whiteColor,
            fontSize: 22.sp,
          ),
        ),
      ),
    );
  }
}
