import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constatnts/colors.dart';
import '../constatnts/variables.dart';

class CustomErrorContainer extends StatelessWidget {
  const CustomErrorContainer({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppVariables.appSize(context).height * 0.3,
      width: AppVariables.appSize(context).width * 0.8,
      decoration: BoxDecoration(
        color: MyColors.creamColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: MyColors.darkBrown),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.cairo(
                  color: MyColors.darkBrown,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
