import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
    required this.dayName,
    required this.dayNum,
    required this.monthName,
    required this.dateNum,
  }) : super(key: key);

  final String dayName;
  final String dayNum;
  final String monthName;
  final String dateNum;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Text(
        '$dayName $dayNum $monthName عام $dateNum',
        style: GoogleFonts.cairo(
          textStyle: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            color: MyColors.babyBrown,
          ),
        ),
      ),
    );
  }
}
