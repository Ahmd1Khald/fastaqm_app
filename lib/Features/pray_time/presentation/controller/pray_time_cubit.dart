import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/PrayerData.dart';
import '../../domain/usecase/pray_time_usecase.dart';

part 'pray_time_state.dart';

class PrayTimeCubit extends Cubit<PrayTimeState> {
  PrayTimeCubit(this.prayTimeUseCase) : super(PrayTimeInitial());
  static PrayTimeCubit get(context) => BlocProvider.of(context);

  PrayerDataModel? prayTimeData;
  final PrayTimeUseCase prayTimeUseCase;

  Future<void> fetchPrayData({
    required String country,
    required String date,
  }) async {
    emit(PrayTimeLoadingFetchData());
    var result = await prayTimeUseCase
        .execute(
      country: country,
      date: date,
    )
        .catchError((error) {
      emit(PrayTimeErrorFetchData());
      print("emited success");
      print(error.toString());
    });
    result.fold((failure) {
      emit(PrayTimeErrorFetchData());
    }, (data) {
      prayTimeData = data;
      print("----------------------");
      //print(prayTimeData?.data['timings']);
      emit(PrayTimeSuccessFetchData(data));
    });
  }
}