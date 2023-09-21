import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/colors.dart';

class BackGroundWidget extends StatelessWidget {
  const BackGroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsManager.backgraoundImage),
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_forward,
              size: 32,
              color: MyColors.darkBrown,
            ),
          ),
        ),
      ],
    );
  }
}
