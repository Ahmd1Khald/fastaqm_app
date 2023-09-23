import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Core/constatnts/variables.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());
  static AzkarCubit get(context) => BlocProvider.of(context);

  Future<String> loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/azkar.json');
    return jsonString;
  }

  Future<void> fetchAzkarData() async {
    try {
      final jsonString = await loadJsonData();
      final jsonData = json.decode(jsonString);
      print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }

  void changeSelectedAzkarIcon(index) {
    AppVariables.azkarSelected = index;
    emit(AzkarCkangeSelectedIcon());
  }
}
