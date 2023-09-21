part of 'pray_time_cubit.dart';

abstract class PrayTimeState {}

class PrayTimeInitial extends PrayTimeState {}

class SetUpPrayTimeState extends PrayTimeState {}

class PrayTimeLoadingFetchData extends PrayTimeState {}

class PrayTimeSuccessFetchData extends PrayTimeState {
  final PrayerDataModel data;
  PrayTimeSuccessFetchData(this.data);
}

class PrayTimeErrorFetchData extends PrayTimeState {
  final String error;
  PrayTimeErrorFetchData(this.error);
}
