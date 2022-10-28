import 'package:bloc/bloc.dart';
import 'package:mento_mind_assignment/modal/test_modal.dart';
import 'package:mento_mind_assignment/repository/test_repository.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  TestRepository testRepository;
  DataBloc(this.testRepository) : super(DataInitial()) {
    on<DataLoadingEvent>((event, emit) async {
      
      final tests = await testRepository.getTests();
      emit(DataLoadedState(tests));
    });
   
  }
}
