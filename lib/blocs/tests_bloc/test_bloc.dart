import 'package:bloc/bloc.dart';

import 'package:mento_mind_assignment/modal/hive_modal/test_modal.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<TestLoadedEvent>((event, emit) async {
      emit(TestInitial());
      Box box = await Hive.openBox<TestModal>('Tests');
      List<TestModal> list = box.values.toList().cast<TestModal>();
     list.sort(((a, b) => b.time.compareTo(a.time)));
      emit(TestLoadedState(list));
    });
    on<TestAddEvent>(
      (event, emit) async {
        Box box = await Hive.openBox<TestModal>('Tests');
        box.add(event.testModal);
        List<TestModal> list = box.values.toList().cast<TestModal>();
        list.sort(((a, b) => b.time.compareTo(a.time)));
        emit(TestLoadedState(list));
      },
    );
  }
}
