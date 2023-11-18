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

  //device token

  static String? deviceToken;

  static List<String> mashaikhAudio = [
    "المنشاوي - مجود",
    "المنشاوي - مرتل",
    "الحصري - مجود",
    "الحصري - مجود",
    "مصطفى اسماعيل",
    "عبدالباسط - مجود",
    "عبدالباسط - مرتل",
    "البنى - مرتل",
    "البنى - مرتل",
    "ماهر المعيقلي",
    "صلاح بو خاطر",
    "سعد الغامدي",
    "سعود الشريم",
  ];
}
