import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constatnts/colors.dart';

class AppTheme {
  static lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: MyColors.creamColor,
      colorScheme: ColorScheme.fromSeed(seedColor: MyColors.lightBrown),
      primaryColor: MyColors.lightBrown,
      sliderTheme: const SliderThemeData(
        disabledActiveTrackColor: MyColors.darkBrown,
        disabledInactiveTrackColor: MyColors.lightBrown,
        disabledThumbColor: MyColors.darkBrown,
      ),

      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(
      //     backgroundColor:
      //         MaterialStateColor.resolveWith((states) => MyColors.myPurble),
      //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //       RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //     ),
      //   ),
      // ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.notoNastaliqUrdu(
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: MyColors.darkBrown,
          ),
        ),
        bodyMedium: GoogleFonts.cairo(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.babyBrown, //Color.fromRGBO(73, 71, 71, 1),
          ),
        ),
      ),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: MyColors.creamColor,
        iconTheme: const IconThemeData(color: MyColors.darkBrown, size: 32),
        titleTextStyle: GoogleFonts.cairo(
          color: MyColors.primaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
    );
  }
}
