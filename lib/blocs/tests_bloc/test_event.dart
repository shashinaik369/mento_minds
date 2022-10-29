part of 'test_bloc.dart';

@immutable
abstract class TestEvent {}

class TestLoadedEvent extends TestEvent {
  
}

class TestAddEvent extends TestEvent {
  TestModal testModal;
  TestAddEvent(this.testModal);
}
