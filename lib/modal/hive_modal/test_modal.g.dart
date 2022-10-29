// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestModalAdapter extends TypeAdapter<TestModal> {
  @override
  final int typeId = 0;

  @override
  TestModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestModal(
      title: fields[0] as String,
      time: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TestModal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
