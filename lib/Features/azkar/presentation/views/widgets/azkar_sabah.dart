import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/variables.dart';

class AzkarSabah extends StatelessWidget {
  const AzkarSabah(
      {Key? key, required this.containerColor, required this.iconColor})
      : super(key: key);

  final Color containerColor;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: AppVariables.appSize(context).width * 0.2,
        height: AppVariables.appSize(context).width * 0.2,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Image.asset(
            AssetsManager.sunIcon,
            color: iconColor,
            width: AppVariables.appSize(context).width * 0.15,
          ),
        ),
      ),
    );
  }
}
