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
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: GoogleFonts.noticiaText(
              color: MyColors.whiteColor,
              fontSize: 24.5.sp,
            ),
          ),
        ),
      ),
    );
  }
}
