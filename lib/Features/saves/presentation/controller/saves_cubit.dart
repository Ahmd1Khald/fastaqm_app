import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Core/constatnts/variables.dart';

part 'saves_state.dart';

class SavesCubit extends Cubit<SavesState> {
  SavesCubit() : super(SavesInitial());
  static SavesCubit get(context) => BlocProvider.of(context);

  void setUp() {
    AppVariables.hadishSaveIndex = 0;
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

  void removedFromList({required int number}) {
    print(AppVariables.hadishSaveIndex);
    if ((AppVariables.hadishSaveLists
        .where((element) => element.number == number)).isNotEmpty) {
      AppVariables.hadishSaveLists
          .removeWhere((element) => element.number == number);
      print("removed");
    }
    backHadith();
    print(AppVariables.hadishSaveIndex);
    print(AppVariables.hadishSaveLists.length);
    emit(SavesRemoveFromList());
  }

  bool ssInSavedList({required int number}) {
    if ((AppVariables.hadishSaveLists
        .where((element) => element.number == number)).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
