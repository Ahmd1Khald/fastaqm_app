import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/helpers/cachehelper.dart';

part 'saves_state.dart';

class SavesCubit extends Cubit<SavesState> {
  SavesCubit() : super(SavesInitial());
  static SavesCubit get(context) => BlocProvider.of(context);

  Future<String> loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/ahadith.json');
    return jsonString;
  }

  List<Map<String, dynamic>> ahadithFavList = [];
  var listOfFavKeys =
      CacheHelper.getDate(key: AppStrings.ahadithSavesKey) ?? [];

  Future<void> fetchFavAhadithData() async {
    try {
      for (String value in listOfFavKeys) {
        if ((semiFavKeysList.where((element) => element == value)).isEmpty) {
          semiFavKeysList.add(value);
        }
      }
      AppVariables.hadishSaveIndex = 0;
      emit(SavesLoadingFetchData());
      final jsonString = await loadJsonData();
      final jsonData = json.decode(jsonString);

      //int i =0;
      for (var value in jsonData) {
        if (listOfFavKeys.contains(value["number"].toString())) {
          ahadithFavList.add(value);
        }
      }
      print(ahadithFavList);
      print(listOfFavKeys);

      emit(SavesSuccessFetchData());
      //print(ahadithList[0]);
      //print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }

  void nextHadith({required int len}) {
    print(len - AppVariables.hadishSaveIndex);
    if (len - AppVariables.hadishSaveIndex > 0) {
      AppVariables.hadishSaveIndex++;
      emit(SavesChangeNext());
    }
  }

  void backHadith() {
    if (AppVariables.hadishSaveIndex > 0) {
      AppVariables.hadishSaveIndex--;
      emit(SavesChangeBack());
    }
  }

  bool selected1 = false;

  void changeSelectedIcon({required int tt}) {
    if (tt == 1) {
      selected1 = !selected1;
      emit(SavesChangeSelectedIcon());
    } else if (tt == 0) {
      selected1 = false;
      emit(SavesChangeSelectedIcon());
    }
  }

  List<String> semiFavKeysList = [];
  void removedFromList({required int number}) {
    print(semiFavKeysList);
    //print(AppVariables.hadishSaveIndex);
    if ((ahadithFavList.where((element) => element["number"] == number))
        .isNotEmpty) {
      ahadithFavList.removeWhere((element) => element["number"] == number);

      semiFavKeysList.remove(number.toString());
      CacheHelper.saveListOfStrings(
        key: AppStrings.ahadithSavesKey,
        value: semiFavKeysList,
      );

      print(semiFavKeysList);
      // CacheHelper.saveData(
      //     key: AppStrings.ahadithSavesKey, value: listOfFavKeys);

      print("removed");
    }
    backHadith();
    emit(SavesRemoveFromList());
  }

  bool ssInSavedList({required int number}) {
    if ((ahadithFavList.where((element) => element["number"] == number))
        .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
