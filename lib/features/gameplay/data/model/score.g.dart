// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreImplAdapter extends TypeAdapter<_$ScoreImpl> {
  @override
  final int typeId = 4;

  @override
  _$ScoreImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$ScoreImpl(
      id: fields[1] as String,
      playedAt: fields[2] as DateTime,
      factId: fields[3] as String,
      userId: fields[4] as String,
      score: fields[5] as int,
      difficulty: fields[6] as Difficulty,
      totalScore: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$ScoreImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.playedAt)
      ..writeByte(3)
      ..write(obj.factId)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.score)
      ..writeByte(6)
      ..write(obj.difficulty)
      ..writeByte(7)
      ..write(obj.totalScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScoreImpl _$$ScoreImplFromJson(Map<String, dynamic> json) => _$ScoreImpl(
      id: json['id'] as String,
      playedAt: DateTime.parse(json['playedAt'] as String),
      factId: json['factId'] as String,
      userId: json['userId'] as String,
      score: (json['score'] as num).toInt(),
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      totalScore: (json['totalScore'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$ScoreImplToJson(_$ScoreImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playedAt': instance.playedAt.toIso8601String(),
      'factId': instance.factId,
      'userId': instance.userId,
      'score': instance.score,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'totalScore': instance.totalScore,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};
