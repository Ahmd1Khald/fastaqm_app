import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'duaa_state.dart';

class DuaaCubit extends Cubit<DuaaState> {
  DuaaCubit() : super(DuaaInitial());

  static DuaaCubit get(context) => BlocProvider.of(context);

  Future<String> loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/azkar.json');
    return jsonString;
  }

  // List<Map<String, dynamic>> azkarAlsabah = [];
  // List<Map<String, dynamic>> azkarAlmasaa = [];
  // List<Map<String, dynamic>> azkarAlnom = [];
  Future<void> fetchDuaaData() async {
    try {
      emit(DuaaLoadingFetchData());
      final jsonString = await loadJsonData();
      final jsonData = json.decode(jsonString);
      //int i =0;
      for (var value in jsonData) {
        // if (value['category'] == "أذكار الصباح") {
        //   azkarAlsabah.add(value);
        // } else if (value['category'] == "أذكار المساء") {
        //   azkarAlmasaa.add(value);
        // } else if (value['category'] == "أذكار النوم") {
        //   azkarAlnom.add(value);
        // }
      }
      emit(DuaaSuccessFetchData());
      //print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }
}
