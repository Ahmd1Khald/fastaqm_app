import 'package:flutter/material.dart';

class AppVariables {
  static Size appSize(context) {
    Size size = MediaQuery.of(context).size;
    return size;
  }
}
