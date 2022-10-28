// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localNotes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalNoteModelAdapter extends TypeAdapter<LocalNoteModel> {
  @override
  final int typeId = 1;

  @override
  LocalNoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalNoteModel(
      title: fields[0] as String?,
      isComplete: fields[2] as bool?,
      created: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalNoteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isComplete)
      ..writeByte(5)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalNoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
