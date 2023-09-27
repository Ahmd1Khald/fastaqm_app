import 'package:fastaqm_app/Features/ahadith/data/model/hadith_model.dart';
import 'package:flutter/material.dart';

class AppVariables {
  static Size appSize(context) {
    Size size = MediaQuery.of(context).size;
    return size;
  }

  static int azkarSelected = 0;
  static int duaaSelected = 0;
  static int ahadithSelected = 0;

  //saves
  static List<HadithModel> hadishSaveLists = [];
  static int hadishSaveIndex = 0;
}
