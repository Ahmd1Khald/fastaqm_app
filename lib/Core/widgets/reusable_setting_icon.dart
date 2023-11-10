import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constatnts/colors.dart';

SizedBox reusableSettingWidget(
    {required VoidCallback fnc, required context, required bool isQuran}) {
  return SizedBox(
    width: AppVariables.appSize(context).width * 0.4,
    child: MaterialButton(
      onPressed: fnc,
      height: 35,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: !isQuran
          ? MyColors.darkBrown
          : const Color.fromARGB(255, 253, 247, 230),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.settings,
            color: !isQuran ? MyColors.lightBrown : MyColors.darkBrown,
            size: 24,
          ),
          Text(
            'حجم الخط',
            style: GoogleFonts.noticiaText(
                color: !isQuran ? MyColors.lightBrown : MyColors.darkBrown,
                fontSize: 20.sp),
          ),
        ],
      ),
    ),
  );
}
