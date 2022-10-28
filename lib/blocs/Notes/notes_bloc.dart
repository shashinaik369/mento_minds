import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/material.dart';
import 'package:mento_mind_assignment/modal/hive_modal/localNotes_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState()) {
    on<AddNoteFrave>(_addNewNote);
    
  }

  Future<void> _addNewNote(AddNoteFrave event, Emitter<NotesState> emit) async {
    var box = Hive.box<LocalNoteModel>('TestsCreated');

    var noteModel = LocalNoteModel(
        title: event.title,
        isComplete: event.isComplete,
        created: DateTime.now());

    box.add(noteModel);
  }
}
