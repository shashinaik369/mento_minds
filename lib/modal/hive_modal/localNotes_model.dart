import 'package:hive/hive.dart';

part 'localNotes_model.g.dart';

@HiveType(typeId: 1)
class LocalNoteModel {
  @HiveField(0)
  String? title;

  @HiveField(2)
  bool? isComplete;

  @HiveField(5)
  DateTime? created;

  LocalNoteModel({this.title, this.isComplete, this.created});
}
