import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class BackZikerWidget extends StatelessWidget {
  const BackZikerWidget({Key? key, required this.fnc}) : super(key: key);

  final VoidCallback fnc;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: fnc,
      height: AppVariables.appSize(context).width * 0.1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      color: MyColors.darkBrown,
      splashColor: MyColors.lightBrown,
      child: const Center(
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 60,
          color: MyColors.whiteColor,
        ),
      ),
    );
  }
}
