import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/constant.dart';
import '../../../../Core/helpers/cachehelper.dart';

part 'pray_time_state.dart';

class PrayTimeCubit extends Cubit<PrayTimeState> {
  PrayTimeCubit() : super(PrayTimeInitial());
  static PrayTimeCubit get(context) => BlocProvider.of(context);

  //PrayerDataModel? prayTimeData;
  //final PrayTimeUseCase prayTimeUseCase;

  // Future<void> fetchPrayData({
  //   required String country,
  //   required String date,
  // }) async {
  //   emit(PrayTimeLoadingFetchData());
  //   testPrayTime();
  //   var result = await prayTimeUseCase
  //       .execute(
  //     country: country,
  //     date: date,
  //   )
  //       .catchError((error) {
  //     emit(PrayTimeErrorFetchData());
  //     print("emited success");
  //     print(error.toString());
  //   });
  //   result.fold((failure) {
  //     emit(PrayTimeErrorFetchData());
  //   }, (data) {
  //     prayTimeData = data;
  //     print("----------------------");
  //     //print(prayTimeData?.data['timings']);
  //     emit(PrayTimeSuccessFetchData(data));
  //   });
  // }

  Prayer? nextPray;
  DateTime? timeForNextPray;
  Future<void> fetchPrayData() async {
    // CacheHelper.removeData(key: AppStrings.latKey);
    // CacheHelper.removeData(key: AppStrings.longKey);
    print('My Prayer Times');
    try {
      emit(PrayTimeLoadingFetchData());
      final myCoordinates = Coordinates(
        CacheHelper.getDate(key: AppStrings.latKey),
        CacheHelper.getDate(key: AppStrings.longKey),
      ); // Replace with your own location lat, lng.
      final params = CalculationMethod.egyptian.getParameters();
      params.madhab = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(myCoordinates, params);
      nextPray = prayerTimes.nextPrayer() == Prayer.none
          ? Prayer.fajr
          : prayerTimes.nextPrayer();
      timeForNextPray = prayerTimes.timeForPrayer(nextPray!);
      print("nextPray");
      print(nextPray);
      print("timeForNextPray");
      print(timeForNextPray);

      print("${prayerTimes.fajr.hour - 1}:${prayerTimes.fajr.minute}");
      print("${prayerTimes.fajr.hour - 1}:${prayerTimes.fajr.minute}");
      print("${prayerTimes.fajr.hour - 1}:${prayerTimes.fajr.minute}");
      fajrTime = "${prayerTimes.fajr.hour - 1}:${prayerTimes.fajr.minute}";
      shroukTime =
          "${prayerTimes.sunrise.hour - 1}:${prayerTimes.sunrise.minute}";
      duhrTime = "${prayerTimes.dhuhr.hour - 1}:${prayerTimes.dhuhr.minute}";
      asrTime = "${prayerTimes.asr.hour - 1}:${prayerTimes.asr.minute}";
      maghrbTime =
          "${prayerTimes.maghrib.hour - 1}:${prayerTimes.maghrib.minute}";
      ishaTime = "${prayerTimes.isha.hour - 1}:${prayerTimes.isha.minute}";
      emit(PrayTimeSuccessFetchData());
    } catch (error) {
      emit(PrayTimeErrorFetchData());
    }

    //print(prayerTimes.fajr);
    // print(DateFormat.jm().format(prayerTimes.sunrise));
    // print(DateFormat.jm().format(prayerTimes.dhuhr));
    // print(DateFormat.jm().format(prayerTimes.asr));
    // print(DateFormat.jm().format(prayerTimes.maghrib));
    // print(DateFormat.jm().format(prayerTimes.isha));
  }
}
