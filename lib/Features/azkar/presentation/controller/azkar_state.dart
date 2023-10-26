part of 'azkar_cubit.dart';

@immutable
abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoadingFetchData extends AzkarState {}

class AzkarSuccessFetchData extends AzkarState {}

class AzkarChangeSelectedIcon extends AzkarState {}

class AzkarIncreaseIndex extends AzkarState {}

class AzkarIncreaseCounter extends AzkarState {}

class AzkarResetCounter extends AzkarState {}

class AzkarDecreaseIndex extends AzkarState {}

class AzkarUpdateSliderValue extends AzkarState {}

class AzkarShowSliderValue extends AzkarState {}

class AzkarChangeFontValue extends AzkarState {}
