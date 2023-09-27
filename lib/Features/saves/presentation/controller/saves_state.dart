part of 'saves_cubit.dart';

@immutable
abstract class SavesState {}

class SavesInitial extends SavesState {}

class SavesChangeNext extends SavesState {}

class SavesChangeBack extends SavesState {}

class SavesRemoveFromList extends SavesState {}

class SavesChangeSelectedIcon extends SavesState {}
