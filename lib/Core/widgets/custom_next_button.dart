import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({Key? key, required this.fnc}) : super(key: key);

  final VoidCallback fnc;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: fnc,
      elevation: 5,
      height: AppVariables.appSize(context).width * 0.08,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      color: MyColors.darkBrown,
      splashColor: MyColors.lightBrown,
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_right,
          size: 55.sp,
          color: MyColors.whiteColor,
        ),
      ),
    );
  }
}
