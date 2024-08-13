// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sections.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionAdapter extends TypeAdapter<Section> {
  @override
  final int typeId = 3;

  @override
  Section read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Section.climateChange;
      case 1:
        return Section.sustainableCommunities;
      case 2:
        return Section.lifeOnLand;
      case 3:
        return Section.cleanEnergy;
      case 4:
        return Section.oceanLife;
      case 5:
        return Section.cleanWaterAndSanitation;
      default:
        return Section.climateChange;
    }
  }

  @override
  void write(BinaryWriter writer, Section obj) {
    switch (obj) {
      case Section.climateChange:
        writer.writeByte(0);
        break;
      case Section.sustainableCommunities:
        writer.writeByte(1);
        break;
      case Section.lifeOnLand:
        writer.writeByte(2);
        break;
      case Section.cleanEnergy:
        writer.writeByte(3);
        break;
      case Section.oceanLife:
        writer.writeByte(4);
        break;
      case Section.cleanWaterAndSanitation:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
