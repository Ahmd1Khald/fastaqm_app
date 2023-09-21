import 'package:flutter/material.dart';

import '../constatnts/colors.dart';

FloatingActionButton customFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.pop(context);
    },
    backgroundColor: MyColors.lightBrown,
    child: const Icon(
      Icons.arrow_forward,
      size: 32,
      color: MyColors.darkBrown,
    ),
  );
}
