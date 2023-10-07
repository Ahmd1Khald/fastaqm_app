import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomContantContainer extends StatelessWidget {
  const CustomContantContainer({Key? key, required this.text})
      : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppVariables.appSize(context).width * 0.85,
      height: AppVariables.appSize(context).width * 0.8,
      decoration: BoxDecoration(
        color: MyColors.lightBrown,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12,
        ),
        child: SingleChildScrollView(
          child: Text(
            text,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: GoogleFonts.noticiaText(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}