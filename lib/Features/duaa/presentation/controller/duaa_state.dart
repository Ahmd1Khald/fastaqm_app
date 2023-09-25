part of 'duaa_cubit.dart';

@immutable
abstract class DuaaState {}

class DuaaInitial extends DuaaState {}

class DuaaLoadingFetchData extends DuaaState {}

class DuaaSuccessFetchData extends DuaaState {}

class DuaaChangeNext extends DuaaState {}

class DuaaChangeBack extends DuaaState {}
