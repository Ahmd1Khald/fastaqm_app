import 'package:flutter/material.dart';

import '../constatnts/colors.dart';

FloatingActionButton customFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.pop(context);
    },
    backgroundColor: MyColors.lightBrown,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: const Icon(
      Icons.arrow_forward_ios_rounded,
      size: 32,
      color: MyColors.darkBrown,
    ),
  );
}
