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

  Future<String> loadJsonData({required bool isHadith}) async {
    final jsonString = isHadith
        ? await rootBundle.loadString('assets/ahadith.json')
        : await rootBundle.loadString('assets/azkar.json');
    return jsonString;
  }

  List<Map<String, dynamic>> ahadithFavList = [];
  List<Map<String, dynamic>> duaaFavList = [];
  var listOfFavKeys =
      CacheHelper.getDate(key: AppStrings.ahadithSavesKey) ?? [];
  var listOfFavKeys2 = CacheHelper.getDate(key: AppStrings.duaaSavesKey) ?? [];

  Future<void> fetchFavAhadithData() async {
    try {
      for (String value in listOfFavKeys) {
        if ((semiFavKeysList.where((element) => element == value)).isEmpty) {
          semiFavKeysList.add(value);
        }
      }
      AppVariables.hadishSaveIndex = 0;
      emit(SavesLoadingFetchData());
      final jsonString = await loadJsonData(isHadith: true);
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

  void nextHadith({required int len, required bool isHadith}) {
    //print(len - AppVariables.duaaSaveIndex);
    if (len - AppVariables.hadishSaveIndex > 0 && isHadith) {
      AppVariables.hadishSaveIndex++;
      emit(SavesChangeNext());
    }
    if (len - AppVariables.duaaSaveIndex > 0 && !isHadith) {
      AppVariables.duaaSaveIndex++;
      emit(SavesChangeNext());
    }
  }

  void backHadith({required bool isHadith}) {
    if (AppVariables.hadishSaveIndex > 0 && isHadith) {
      AppVariables.hadishSaveIndex--;
      emit(SavesChangeBack());
    }
    if (AppVariables.duaaSaveIndex > 0 && !isHadith) {
      AppVariables.duaaSaveIndex--;
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
  List<String> semiFavKeysList2 = [];
  void removedHadithFromList({required int number}) {
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
    backHadith(isHadith: true);
    emit(SavesRemoveFromList());
  }

  bool ssInHadithSavedList({required int number}) {
    if ((ahadithFavList.where((element) => element["number"] == number))
        .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchFavDuaaData() async {
    try {
      for (String value in listOfFavKeys2) {
        if ((semiFavKeysList2.where((element) => element == value)).isEmpty) {
          semiFavKeysList2.add(value);
        }
      }
      AppVariables.duaaSaveIndex = 0;
      emit(SavesLoadingFetchData());
      final jsonString = await loadJsonData(isHadith: false);
      final jsonData = json.decode(jsonString);

      //int i =0;
      for (var value in jsonData) {
        if (listOfFavKeys2.contains(value["zekr"])) {
          duaaFavList.add(value);
        }
      }
      print(duaaFavList);
      print(listOfFavKeys2);

      emit(SavesSuccessFetchData());
      //print(duaaList[0]);
      //print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }

  void removedDuaaFromList({
    required String duaa,
  }) {
    print(semiFavKeysList2);
    //print(AppVariables.hadishSaveIndex);
    if ((duaaFavList.where((element) => element["zekr"] == duaa)).isNotEmpty) {
      duaaFavList.removeWhere((element) => element["zekr"] == duaa);

      semiFavKeysList2.remove(duaa);
      CacheHelper.saveListOfStrings(
        key: AppStrings.duaaSavesKey,
        value: semiFavKeysList2,
      );

      print(semiFavKeysList2);
      // CacheHelper.saveData(
      //     key: AppStrings.duaaSavesKey, value: listOfFavKeys);

      print("removed");
    }
    backHadith(isHadith: false);
    emit(SavesRemoveFromList());
  }

  bool ssInDuaaSavedList({required String duaa}) {
    if ((duaaFavList.where((element) => element["zekr"] == duaa)).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
