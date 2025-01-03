part of 'saves_cubit.dart';

@immutable
abstract class SavesState {}

class SavesInitial extends SavesState {}

class SavesChangeNext extends SavesState {}

class SavesLoadingFetchData extends SavesState {}

class SavesSuccessFetchData extends SavesState {}

class SavesChangeBack extends SavesState {}

class SavesRemoveFromList extends SavesState {}

class SavesChangeSelectedIcon extends SavesState {}

class SavesShowSliderValue extends SavesState {}

class SavesChangeFontValue extends SavesState {}
