import 'package:flutter/material.dart';

import '../constatnts/colors.dart';

void customSnackBar({required context, required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title, textAlign: TextAlign.right),
      backgroundColor: MyColors.darkBrown,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
