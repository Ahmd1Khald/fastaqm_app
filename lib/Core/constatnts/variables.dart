import 'package:flutter/material.dart';

class AppVariables {
  static Size appSize(context) {
    Size size = MediaQuery.of(context).size;
    return size;
  }

  static int azkarSelected = 0;
  static int duaaSelected = 0;
  static int ahadithSelected = 0;

  //saved
  static int hadishSaveIndex = 0;
  static int duaaSaveIndex = 0;
}
