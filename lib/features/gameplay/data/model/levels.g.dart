// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'levels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelsAdapter extends TypeAdapter<Levels> {
  @override
  final int typeId = 2;

  @override
  Levels read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Levels.level_1;
      case 1:
        return Levels.level_2;
      case 2:
        return Levels.level_3;
      case 3:
        return Levels.level_4;
      case 4:
        return Levels.level_5;
      default:
        return Levels.level_1;
    }
  }

  @override
  void write(BinaryWriter writer, Levels obj) {
    switch (obj) {
      case Levels.level_1:
        writer.writeByte(0);
        break;
      case Levels.level_2:
        writer.writeByte(1);
        break;
      case Levels.level_3:
        writer.writeByte(2);
        break;
      case Levels.level_4:
        writer.writeByte(3);
        break;
      case Levels.level_5:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
