// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactImplAdapter extends TypeAdapter<_$FactImpl> {
  @override
  final int typeId = 1;

  @override
  _$FactImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$FactImpl(
      id: fields[1] as String,
      fact: fields[2] as String,
      prologue: fields[3] as String,
      section: fields[4] as Sections,
      level: fields[5] as Levels,
      lastAccessedTime: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$FactImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.fact)
      ..writeByte(3)
      ..write(obj.prologue)
      ..writeByte(4)
      ..write(obj.section)
      ..writeByte(5)
      ..write(obj.level)
      ..writeByte(6)
      ..write(obj.lastAccessedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FactImpl _$$FactImplFromJson(Map<String, dynamic> json) => _$FactImpl(
      id: json['id'] as String,
      fact: json['fact'] as String,
      prologue: json['prologue'] as String,
      section: $enumDecode(_$SectionsEnumMap, json['section']),
      level: $enumDecode(_$LevelsEnumMap, json['level']),
      lastAccessedTime: DateTime.parse(json['lastAccessedTime'] as String),
    );

Map<String, dynamic> _$$FactImplToJson(_$FactImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fact': instance.fact,
      'prologue': instance.prologue,
      'section': _$SectionsEnumMap[instance.section]!,
      'level': _$LevelsEnumMap[instance.level]!,
      'lastAccessedTime': instance.lastAccessedTime.toIso8601String(),
    };

const _$SectionsEnumMap = {
  Sections.scienceAndTech: 'scienceAndTech',
  Sections.historyAndCulture: 'historyAndCulture',
  Sections.natureAndEnvironment: 'natureAndEnvironment',
  Sections.healthAndWellness: 'healthAndWellness',
  Sections.artsAndEntertainment: 'artsAndEntertainment',
  Sections.travelAndExploration: 'travelAndExploration',
};

const _$LevelsEnumMap = {
  Levels.level_1: 'level_1',
  Levels.level_2: 'level_2',
  Levels.level_3: 'level_3',
  Levels.level_4: 'level_4',
  Levels.level_5: 'level_5',
};
