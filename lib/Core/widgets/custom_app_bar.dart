import 'package:flutter/material.dart';

import '../constatnts/colors.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_forward,
            size: 32,
            color: MyColors.darkBrown,
          ))
    ],
  );
}
