import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../views/widgets/azkar_masaa.dart';
import '../views/widgets/azkar_sabah.dart';
import '../views/widgets/azkar_sleep.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());
  static AzkarCubit get(context) => BlocProvider.of(context);

  Future<String> loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/azkar.json');
    return jsonString;
  }

  List<Map<String, dynamic>> azkarAlsabah = [];
  List<Map<String, dynamic>> azkarAlmasaa = [];
  List<Map<String, dynamic>> azkarAlnom = [];
  Future<void> fetchAzkarData() async {
    try {
      emit(AzkarLoadingFetchData());
      final jsonString = await loadJsonData();
      final jsonData = json.decode(jsonString);
      //int i =0;
      for (var value in jsonData) {
        if (value['category'] == "أذكار الصباح") {
          azkarAlsabah.add(value);
        } else if (value['category'] == "أذكار المساء") {
          azkarAlmasaa.add(value);
        } else if (value['category'] == "أذكار الاستيقاظ من النوم") {
          azkarAlnom.add(value);
        }
      }
      emit(AzkarSuccessFetchData());
      //print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }

  void changeSelectedAzkarIcon(index) {
    AppVariables.azkarSelected = index;
    emit(AzkarChangeSelectedIcon());
  }

  int sabahIndex = 0;
  int masaaIndex = 0;
  int nomIndex = 0;
  void incIndex({required int tt}) {
    print(tt);
    if (tt == 0 && azkarAlsabah.length - 1 - sabahIndex > 0) {
      print(azkarAlsabah.length - 1 - sabahIndex);
      sabahIndex++;
      emit(AzkarIncreaseIndex());
    } else if (tt == 1 && azkarAlmasaa.length - 1 - masaaIndex > 0) {
      print(azkarAlmasaa.length - 1 - masaaIndex);
      masaaIndex++;
      emit(AzkarIncreaseIndex());
    } else if (tt == 2 && azkarAlnom.length - 1 - nomIndex > 0) {
      print(azkarAlnom.length - 1 - nomIndex);
      nomIndex++;
      emit(AzkarIncreaseIndex());
    }
  }

  List<Widget> changeSelectedZiker(index) {
    List<Widget> azkars = [
      AzkarSabah(
        containerColor: AppVariables.azkarSelected == index
            ? MyColors.darkBrown
            : MyColors.lightBrown,
        iconColor: AppVariables.azkarSelected == index
            ? MyColors.lightBrown
            : MyColors.darkBrown,
      ),
      AzkarMasaa(
        containerColor: AppVariables.azkarSelected == index
            ? MyColors.darkBrown
            : MyColors.lightBrown,
        iconColor: AppVariables.azkarSelected == index
            ? MyColors.lightBrown
            : MyColors.darkBrown,
      ),
      AzkarSleep(
        containerColor: AppVariables.azkarSelected == index
            ? MyColors.darkBrown
            : MyColors.lightBrown,
        iconColor: AppVariables.azkarSelected == index
            ? MyColors.lightBrown
            : MyColors.darkBrown,
      ),
    ];
    return azkars;
  }
}
