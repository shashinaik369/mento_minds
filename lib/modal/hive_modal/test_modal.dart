import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'test_modal.g.dart';

@HiveType(typeId: 0)
class TestModal extends Equatable {
  
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime time;
  TestModal({required this.title, required this.time});
  
  @override
  // TODO: implement props
  List<Object?> get props => [title,time];
}
