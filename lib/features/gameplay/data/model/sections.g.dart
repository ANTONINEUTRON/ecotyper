// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sections.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionsAdapter extends TypeAdapter<Sections> {
  @override
  final int typeId = 3;

  @override
  Sections read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Sections.scienceAndTech;
      case 1:
        return Sections.historyAndCulture;
      case 2:
        return Sections.natureAndEnvironment;
      case 3:
        return Sections.healthAndWellness;
      case 4:
        return Sections.artsAndEntertainment;
      case 5:
        return Sections.travelAndExploration;
      default:
        return Sections.scienceAndTech;
    }
  }

  @override
  void write(BinaryWriter writer, Sections obj) {
    switch (obj) {
      case Sections.scienceAndTech:
        writer.writeByte(0);
        break;
      case Sections.historyAndCulture:
        writer.writeByte(1);
        break;
      case Sections.natureAndEnvironment:
        writer.writeByte(2);
        break;
      case Sections.healthAndWellness:
        writer.writeByte(3);
        break;
      case Sections.artsAndEntertainment:
        writer.writeByte(4);
        break;
      case Sections.travelAndExploration:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
