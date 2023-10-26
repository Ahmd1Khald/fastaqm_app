import 'package:flutter/material.dart';

import '../constatnts/colors.dart';

void noInternetSnakbar(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('لا يوجد انترنيت', textAlign: TextAlign.right),
      backgroundColor: MyColors.darkBrown,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
