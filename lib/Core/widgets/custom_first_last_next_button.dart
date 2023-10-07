import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constatnts/colors.dart';

class CustomFirstLastNextButton extends StatelessWidget {
  const CustomFirstLastNextButton(
      {Key? key, required this.fnc, required this.isFirst})
      : super(key: key);

  final VoidCallback fnc;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: MyColors.darkBrown,
      radius: 40.sp,
      child: MaterialButton(
        onPressed: fnc,
        elevation: 5,
        //height: AppVariables.appSize(context).width * 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
        color: MyColors.darkBrown,
        splashColor: MyColors.lightBrown,
        child: Center(
          child: Icon(
            isFirst ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
            size: 40.sp,
            color: MyColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
