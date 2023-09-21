import 'package:fastaqm_app/Features/pray_time/data/model/pray_time_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/pray_time_usecase.dart';

part 'pray_time_state.dart';

class PrayTimeCubit extends Cubit<PrayTimeState> {
  PrayTimeCubit(this.prayTimeUseCase) : super(PrayTimeInitial());
  static PrayTimeCubit get(context) => BlocProvider.of(context);

  PrayerTimings? prayTimeData;
  final PrayTimeUseCase prayTimeUseCase;

  Future<void> fetchTopicsList({
    required String country,
    required String date,
  }) async {
    emit(PrayTimeLoadingFetchData());
    var result = await prayTimeUseCase.execute(
      country: country,
      date: date,
    );
    result.fold((failure) {
      emit(PrayTimeErrorFetchData(failure.message));
    }, (data) {
      prayTimeData = data;
      emit(PrayTimeSuccessFetchData(data));
    });
  }
}
