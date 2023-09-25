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

  List<Map<String, dynamic>> duaaNewClothes = [];
  List<Map<String, dynamic>> duaaEnterMosque = [];
  List<Map<String, dynamic>> duaaSalaaEst5ara = [];
  List<Map<String, dynamic>> duaaAlham = [];
  List<Map<String, dynamic>> duaaAlkarb = [];
  List<Map<String, dynamic>> duaaAlkoboor = [];
  List<Map<String, dynamic>> duaaAlreeh = [];
  List<Map<String, dynamic>> duaaAlmatar = [];
  List<Map<String, dynamic>> duaaAlsom = [];
  List<Map<String, dynamic>> duaaAlta3am = [];
  List<Map<String, dynamic>> duaaAlsafar = [];
  List<Map<String, dynamic>> duaaAlsooq = [];
  List<Map<String, dynamic>> duaaAlroqia = [];
  List<Map<String, dynamic>> duaaAlrkoob = [];
  List<Map<String, dynamic>> duaaAld5olAlkaria = [];
  List<Map<String, dynamic>> duaaAlazan = [];
  List<Map<String, dynamic>> duaaAlabtlaa = [];
  List<Map<String, dynamic>> duaaAl5laa = [];

  //list of lists
  List<List<Map<String, dynamic>>> duaaLists = [];
  Future<void> fetchDuaaData() async {
    try {
      emit(DuaaLoadingFetchData());
      final jsonString = await loadJsonData();
      final jsonData = json.decode(jsonString);
      //int i =0;
      for (var value in jsonData) {
        if (value['category'] == "دعاء لبس الثوب الجديد") {
          duaaNewClothes.add(value);
        } else if (value['category'] == "دعاء دخول المسجد") {
          duaaEnterMosque.add(value);
        } else if (value['category'] == "دعاء صلاة الاستخارة") {
          duaaSalaaEst5ara.add(value);
        } else if (value['category'] == "دعاء الهم والحزن") {
          duaaAlham.add(value);
        } else if (value['category'] == "دعاء الكرب") {
          duaaAlkarb.add(value);
        } else if (value['category'] == "دعاء زيارة القبور") {
          duaaAlkoboor.add(value);
        } else if (value['category'] == "دعاء الريح") {
          duaaAlreeh.add(value);
        } else if (value['category'] == "دعاء الريح") {
          duaaAlreeh.add(value);
        } else if (value['category'] == "الدعاء إذا نزل المطر") {
          duaaAlmatar.add(value);
        } else if (value['category'] == "الدعاء عند إفطار الصائم - الصوم") {
          duaaAlsom.add(value);
        } else if (value['category'] == "الدعاء قبل الطعام") {
          duaaAlta3am.add(value);
        } else if (value['category'] == "دعاء السفر") {
          duaaAlsafar.add(value);
        } else if (value['category'] == "دعاء دخول السوق") {
          duaaAlsooq.add(value);
        } else if (value['category'] == "الرُّقية الشرعية من القرآن الكريم") {
          duaaAlroqia.add(value);
        } else if (value['category'] == "دعاء الركوب") {
          duaaAlrkoob.add(value);
        } else if (value['category'] == "دعاء دخول القرية أو البلدة") {
          duaaAld5olAlkaria.add(value);
        } else if (value['category'] == "أذكار الآذان") {
          duaaAlazan.add(value);
        } else if (value['category'] == "دعاء عند رؤية مبتلى") {
          duaaAlabtlaa.add(value);
        } else if (value['category'] == "دعاء دخول الخلاء - الحمام" ||
            value['category'] == "دعاء الخروج من الخلاء - الحمام") {
          duaaAl5laa.add(value);
        }
      }
      duaaLists = [
        duaaNewClothes,
        duaaEnterMosque,
        duaaSalaaEst5ara,
        duaaAl5laa,
        duaaAlham,
        duaaAlkarb,
        duaaAlkoboor,
        duaaAlreeh,
        duaaAlmatar,
        duaaAlsom,
        duaaAlta3am,
        duaaAlsafar,
        duaaAlsooq,
        duaaAlroqia,
        duaaAlrkoob,
        duaaAld5olAlkaria,
        duaaAlazan,
        duaaAlabtlaa,
      ];
      emit(DuaaSuccessFetchData());
      print(duaaAlazan[0]);
      //print(jsonData[0]['zekr']);
    } catch (error) {
      print('Error loading or parsing JSON: $error');
    }
  }
}
