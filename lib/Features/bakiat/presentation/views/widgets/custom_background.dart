import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          AssetsManager.bakiatImage,
          height: AppVariables.appSize(context).height * 0.12,
          fit: BoxFit.fill,
        ),
        Image.asset(
          AssetsManager.ayaBakiatImage,
          fit: BoxFit.fill,
          height: AppVariables.appSize(context).height * 0.08,
        ),
      ],
    );
  }
}
