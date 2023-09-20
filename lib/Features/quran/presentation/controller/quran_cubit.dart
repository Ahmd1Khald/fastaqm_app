import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  static QuranCubit get(context) => BlocProvider.of(context);

  List<int> quranSuraItem = [];
  void setUpQuran() {
    for (int i = 1; i <= 114; i++) {
      quranSuraItem.add(i);
    }
    emit(SetUpQuranState());
  }
}
