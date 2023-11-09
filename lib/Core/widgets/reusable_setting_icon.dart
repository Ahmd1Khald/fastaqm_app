import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constatnts/colors.dart';

SizedBox reusableSettingWidget({required VoidCallback fnc, required context}) {
  return SizedBox(
    width: AppVariables.appSize(context).width * 0.4,
    child: MaterialButton(
      onPressed: fnc,
      height: 25,
      color: MyColors.lightBrown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.settings,
            color: MyColors.darkBrown,
            size: 20,
          ),
          Text(
            'تعديل حجم الخط',
            style: GoogleFonts.noticiaText(
              color: MyColors.darkBrown,
            ),
          ),
        ],
      ),
    ),
  );
}
