part of 'azkar_cubit.dart';

@immutable
abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoadingFetchData extends AzkarState {}

class AzkarSuccessFetchData extends AzkarState {}

class AzkarChangeSelectedIcon extends AzkarState {}

class AzkarIncreaseIndex extends AzkarState {}
