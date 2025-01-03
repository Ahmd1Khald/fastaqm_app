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

  // void onMessageListen(context) {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     if (message.notification != null) {
  //       print("------------------------");
  //       print(message.notification!.title);
  //       print("-------------------------");
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("${message.notification!.body}",
  //               textAlign: TextAlign.right),
  //           backgroundColor: MyColors.darkBrown,
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     }
  //   });
  // }

  Future<void> fetchPrayData(context) async {
    // CacheHelper.removeData(key: AppStrings.latKey);
    // CacheHelper.removeData(key: AppStrings.longKey);
    print('My Prayer Times');
    try {
      //onMessageListen(context);
      emit(PrayTimeLoadingFetchData());
      //setup pray times
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

      print("${prayerTimes.fajr.hour}:${prayerTimes.fajr.minute}");
      fajrTime = "${prayerTimes.fajr.hour}:${prayerTimes.fajr.minute}";
      shroukTime = "${prayerTimes.sunrise.hour}:${prayerTimes.sunrise.minute}";
      duhrTime = "${prayerTimes.dhuhr.hour}:${prayerTimes.dhuhr.minute}";
      asrTime = "${prayerTimes.asr.hour}:${prayerTimes.asr.minute}";
      maghrbTime = "${prayerTimes.maghrib.hour}:${prayerTimes.maghrib.minute}";
      ishaTime = "${prayerTimes.isha.hour}:${prayerTimes.isha.minute}";
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
