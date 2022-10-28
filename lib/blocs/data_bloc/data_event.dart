part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class DataLoadingEvent extends DataEvent {}

class DataLoadedEvent extends DataEvent {}

class DataErrorEvent extends DataEvent {}
