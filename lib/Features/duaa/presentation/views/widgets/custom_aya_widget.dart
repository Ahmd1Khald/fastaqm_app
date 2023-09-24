import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomAyaWidget extends StatelessWidget {
  const CustomAyaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          width: AppVariables.appSize(context).width * 0.999,
          child: Image.asset(
            AssetsManager.bakiatImage,
            height: AppVariables.appSize(context).height * 0.11,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.8,
          child: Text(
            textAlign: TextAlign.center,
            "وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ",
            textDirection: TextDirection.rtl,
            style: GoogleFonts.noticiaText(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
