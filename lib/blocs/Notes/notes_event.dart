part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddNoteFrave extends NotesEvent {
  final String title;
 
  final DateTime created;

  final bool isComplete;

  AddNoteFrave({
    required this.title, 
     
    required this.created, 
   
    required this.isComplete
  });
}





