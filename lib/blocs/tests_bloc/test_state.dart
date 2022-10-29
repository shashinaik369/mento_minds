part of 'test_bloc.dart';

@immutable
abstract class TestState {}

class TestInitial extends TestState {}

class TestLoadedState extends TestState {
  List<TestModal> tests;
  TestLoadedState(this.tests);
}
