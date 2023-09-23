import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class CountZikerWidget extends StatefulWidget {
  const CountZikerWidget({Key? key, required this.num}) : super(key: key);

  @override
  State<CountZikerWidget> createState() => _CountZikerWidgetState();
  final String num;
}

class _CountZikerWidgetState extends State<CountZikerWidget> {
  double silderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: AppVariables.appSize(context).width * 0.17,
              height: AppVariables.appSize(context).width * 0.17,
              decoration: const BoxDecoration(
                color: MyColors.lightBrown,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.num == "" ? '1' : widget.num,
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: MyColors.darkBrown,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppVariables.appSize(context).width * 0.18,
              height: AppVariables.appSize(context).width * 0.18,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                value: silderValue,
                color: MyColors.darkBrown,
                backgroundColor: MyColors.whiteColor,
              ),
            ),
          ],
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.1,
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.35,
          child: MaterialButton(
            onPressed: () {
              setState(() {
                silderValue +=
                    1 / double.parse(widget.num == "" ? '1' : widget.num);
              });
            },
            height: AppVariables.appSize(context).width * 0.14,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: MyColors.darkBrown,
            splashColor: MyColors.lightBrown,
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'ثلاث مرات',
                style: GoogleFonts.notoNastaliqUrdu(
                  color: MyColors.whiteColor,
                  fontSize: 21,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
