part of 'ahadith_cubit.dart';

@immutable
abstract class AhadithState {}

class AhadithInitial extends AhadithState {}

class AhadithLoadingFetchData extends AhadithState {}

class AhadithSuccessFetchData extends AhadithState {}

class AhadithChangeNext extends AhadithState {}

class AhadithChangeBack extends AhadithState {}

class AhadithChangeSelectedIcon extends AhadithState {}

class AhadithSaveToList extends AhadithState {}

class AhadithShowSliderValue extends AhadithState {}

class AhadithChangeFontValue extends AhadithState {}
