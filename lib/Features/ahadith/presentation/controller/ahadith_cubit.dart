import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Core/constatnts/variables.dart';

part 'ahadith_state.dart';

class AhadithCubit extends Cubit<AhadithState> {
  AhadithCubit() : super(AhadithInitial());

  static AhadithCubit get(context) => BlocProvider.of(context);

  Future<String> loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/ahadith.json');
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
      print(ahadithList[0]);
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
}
