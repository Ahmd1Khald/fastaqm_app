import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class NextZikerWidget extends StatelessWidget {
  const NextZikerWidget({Key? key, required this.fnc}) : super(key: key);

  final VoidCallback fnc;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppVariables.appSize(context).width * 0.21,
      height: AppVariables.appSize(context).width * 0.21,
      child: MaterialButton(
        onPressed: fnc,
        height: AppVariables.appSize(context).width * 0.21,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        color: MyColors.darkBrown,
        splashColor: MyColors.lightBrown,
        child: const Center(
          child: Icon(
            Icons.keyboard_arrow_right,
            size: 55,
            color: MyColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
