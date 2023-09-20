import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/variables.dart';

class QuranImage extends StatelessWidget {
  const QuranImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AssetsManager.quranImage,
        width: AppVariables.appSize(context).width * 0.7,
      ),
    );
  }
}
