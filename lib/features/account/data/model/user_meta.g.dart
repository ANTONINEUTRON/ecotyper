// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserMetaImplAdapter extends TypeAdapter<_$UserMetaImpl> {
  @override
  final int typeId = 6;

  @override
  _$UserMetaImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$UserMetaImpl(
      accessibleLevels: (fields[1] as List).cast<Levels>(),
      selectedDifficulty: fields[2] as Difficulty,
    );
  }

  @override
  void write(BinaryWriter writer, _$UserMetaImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(2)
      ..write(obj.selectedDifficulty)
      ..writeByte(1)
      ..write(obj.accessibleLevels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserMetaImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMetaImpl _$$UserMetaImplFromJson(Map<String, dynamic> json) =>
    _$UserMetaImpl(
      accessibleLevels: (json['accessibleLevels'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$LevelsEnumMap, e))
              .toList() ??
          const [Levels.level_1],
      selectedDifficulty: $enumDecodeNullable(
              _$DifficultyEnumMap, json['selectedDifficulty']) ??
          Difficulty.easy,
    );

Map<String, dynamic> _$$UserMetaImplToJson(_$UserMetaImpl instance) =>
    <String, dynamic>{
      'accessibleLevels':
          instance.accessibleLevels.map((e) => _$LevelsEnumMap[e]!).toList(),
      'selectedDifficulty': _$DifficultyEnumMap[instance.selectedDifficulty]!,
    };

const _$LevelsEnumMap = {
  Levels.level_1: 'level_1',
  Levels.level_2: 'level_2',
  Levels.level_3: 'level_3',
  Levels.level_4: 'level_4',
  Levels.level_5: 'level_5',
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};
