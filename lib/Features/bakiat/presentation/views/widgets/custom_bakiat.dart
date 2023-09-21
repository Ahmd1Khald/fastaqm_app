import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomBakiat extends StatefulWidget {
  const CustomBakiat({Key? key, required this.text}) : super(key: key);

  @override
  State<CustomBakiat> createState() => _CustomBakiatState();
  final String text;
}

class _CustomBakiatState extends State<CustomBakiat> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
      child: Row(
        children: [
          Container(
            width: AppVariables.appSize(context).width * 0.2,
            height: AppVariables.appSize(context).width * 0.2,
            decoration: BoxDecoration(
              color: MyColors.lightBrown,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                '$num'.length > 4 ? "$num k+" : '$num',
                style: GoogleFonts.cairo(
                  color: MyColors.darkBrown,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: AppVariables.appSize(context).width * 0.46,
            height: AppVariables.appSize(context).width * 0.15,
            decoration: BoxDecoration(
              color: MyColors.darkBrown,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: GoogleFonts.notoNastaliqUrdu(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppVariables.appSize(context).width * 0.02,
          ),
          SizedBox(
            width: AppVariables.appSize(context).width * 0.17,
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  num += 1;
                });
              },
              height: AppVariables.appSize(context).width * 0.14,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              color: MyColors.darkBrown,
              splashColor: MyColors.lightBrown,
              child: const Icon(
                Icons.add,
                color: MyColors.whiteColor,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
