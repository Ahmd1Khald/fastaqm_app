import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../data/model/hadith_model.dart';

part 'ahadith_state.dart';

class AhadithCubit extends Cubit<AhadithState> {
  AhadithCubit() : super(AhadithInitial());

  static AhadithCubit get(context) => BlocProvider.of(context);

  Future<String> loadJsonData() async {
    final jsonString =
        await rootBundle.loadString('assets/ahadithNawawia.json');
    return jsonString;
  }

  List<Map<String, dynamic>> ahadithList = [];
  Future<void> fetchAhadithData() async {
    try {
      AppVariables.ahadithSelected = 0;
      emit(AhadithLoadingFetchData());
      final jsonString = await loadJsonData();
      final jsonData = json.decode(jsonString);
      //int i =0;
      for (var value in jsonData) {
        ahadithList.add(value);
      }
      emit(AhadithSuccessFetchData());
      //print(ahadithList[0]);
      //print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }

  void nextHadith({required int len}) {
    if (len - AppVariables.ahadithSelected > 0) {
      AppVariables.ahadithSelected++;
      emit(AhadithChangeNext());
    }
  }

  void backHadith() {
    if (AppVariables.ahadithSelected > 0) {
      AppVariables.ahadithSelected--;
      emit(AhadithChangeBack());
    }
  }

  bool selected1 = false;

  void changeSelectedIcon({required int tt}) {
    if (tt == 1) {
      selected1 = !selected1;
      emit(AhadithChangeSelectedIcon());
    } else if (tt == 0) {
      selected1 = false;
      emit(AhadithChangeSelectedIcon());
    }
  }

  List<String>? listOfFavKeys =
      CacheHelper.getFavDate(key: AppStrings.ahadithSavesKey);
  List<String> semiFavKeysList = [];

  void saveToList({required HadithModel model}) {
    for (String value in listOfFavKeys!) {
      semiFavKeysList.add(value);
    }
    print(semiFavKeysList);
    if (semiFavKeysList.contains(model.number.toString())) {
      semiFavKeysList
          .removeWhere((element) => element == model.number.toString());
      CacheHelper.saveListOfStrings(
        key: AppStrings.ahadithSavesKey,
        value: semiFavKeysList,
      );
      print(semiFavKeysList);
      print("removed");
    } else {
      semiFavKeysList.add(model.number.toString());
      CacheHelper.saveListOfStrings(
        key: AppStrings.ahadithSavesKey,
        value: semiFavKeysList,
      );
      print(semiFavKeysList);
      print("added");
    }
    emit(AhadithSaveToList());
  }

  bool ssInSavedList({required int number}) {
    listOfFavKeys =
        CacheHelper.getFavDate(key: AppStrings.ahadithSavesKey) ?? [];
    if ((listOfFavKeys!.where((element) => element == number.toString()))
        .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool showSlider = false;
  double sliderValue =
      CacheHelper.getDate(key: AppStrings.containerFontKey) ?? 24;
  void showSliderFunc(bool t) {
    if (t) {
      showSlider = !showSlider;
    } else {
      showSlider = false;
    }
    emit(AhadithShowSliderValue());
  }

  void changeFontValue(double value) {
    sliderValue = value;
    CacheHelper.saveData(key: AppStrings.containerFontKey, value: sliderValue);
    emit(AhadithChangeFontValue());
  }
}
