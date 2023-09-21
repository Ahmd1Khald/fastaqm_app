import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/assets_manager.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsManager.backgraoundImage),
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
