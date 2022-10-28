part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class DataLoadingState extends DataState {}

class DataLoadedState extends DataState {
  List<Topics> topics;
  DataLoadedState(this.topics);
}

class DataErrorState extends DataState {}
