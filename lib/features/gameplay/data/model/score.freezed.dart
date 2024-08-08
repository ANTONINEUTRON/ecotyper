// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return _Score.fromJson(json);
}

/// @nodoc
mixin _$Score {
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get playedAt => throw _privateConstructorUsedError;
  @HiveField(3)
  String get factId => throw _privateConstructorUsedError;
  @HiveField(4)
  String get userId => throw _privateConstructorUsedError;
  @HiveField(5)
  int get score => throw _privateConstructorUsedError;
  @HiveField(6)
  Difficulty get difficulty => throw _privateConstructorUsedError;
  @HiveField(7)
  int get totalScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreCopyWith<Score> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreCopyWith<$Res> {
  factory $ScoreCopyWith(Score value, $Res Function(Score) then) =
      _$ScoreCopyWithImpl<$Res, Score>;
  @useResult
  $Res call(
      {@HiveField(1) String id,
      @HiveField(2) DateTime playedAt,
      @HiveField(3) String factId,
      @HiveField(4) String userId,
      @HiveField(5) int score,
      @HiveField(6) Difficulty difficulty,
      @HiveField(7) int totalScore});
}

/// @nodoc
class _$ScoreCopyWithImpl<$Res, $Val extends Score>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playedAt = null,
    Object? factId = null,
    Object? userId = null,
    Object? score = null,
    Object? difficulty = null,
    Object? totalScore = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playedAt: null == playedAt
          ? _value.playedAt
          : playedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      factId: null == factId
          ? _value.factId
          : factId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreImplCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$$ScoreImplCopyWith(
          _$ScoreImpl value, $Res Function(_$ScoreImpl) then) =
      __$$ScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(1) String id,
      @HiveField(2) DateTime playedAt,
      @HiveField(3) String factId,
      @HiveField(4) String userId,
      @HiveField(5) int score,
      @HiveField(6) Difficulty difficulty,
      @HiveField(7) int totalScore});
}

/// @nodoc
class __$$ScoreImplCopyWithImpl<$Res>
    extends _$ScoreCopyWithImpl<$Res, _$ScoreImpl>
    implements _$$ScoreImplCopyWith<$Res> {
  __$$ScoreImplCopyWithImpl(
      _$ScoreImpl _value, $Res Function(_$ScoreImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playedAt = null,
    Object? factId = null,
    Object? userId = null,
    Object? score = null,
    Object? difficulty = null,
    Object? totalScore = null,
  }) {
    return _then(_$ScoreImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playedAt: null == playedAt
          ? _value.playedAt
          : playedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      factId: null == factId
          ? _value.factId
          : factId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 4)
class _$ScoreImpl extends _Score {
  _$ScoreImpl(
      {@HiveField(1) required this.id,
      @HiveField(2) required this.playedAt,
      @HiveField(3) required this.factId,
      @HiveField(4) required this.userId,
      @HiveField(5) required this.score,
      @HiveField(6) required this.difficulty,
      @HiveField(7) this.totalScore = 100})
      : super._();

  factory _$ScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreImplFromJson(json);

  @override
  @HiveField(1)
  final String id;
  @override
  @HiveField(2)
  final DateTime playedAt;
  @override
  @HiveField(3)
  final String factId;
  @override
  @HiveField(4)
  final String userId;
  @override
  @HiveField(5)
  final int score;
  @override
  @HiveField(6)
  final Difficulty difficulty;
  @override
  @JsonKey()
  @HiveField(7)
  final int totalScore;

  @override
  String toString() {
    return 'Score(id: $id, playedAt: $playedAt, factId: $factId, userId: $userId, score: $score, difficulty: $difficulty, totalScore: $totalScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playedAt, playedAt) ||
                other.playedAt == playedAt) &&
            (identical(other.factId, factId) || other.factId == factId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, playedAt, factId, userId, score, difficulty, totalScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      __$$ScoreImplCopyWithImpl<_$ScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreImplToJson(
      this,
    );
  }
}

abstract class _Score extends Score {
  factory _Score(
      {@HiveField(1) required final String id,
      @HiveField(2) required final DateTime playedAt,
      @HiveField(3) required final String factId,
      @HiveField(4) required final String userId,
      @HiveField(5) required final int score,
      @HiveField(6) required final Difficulty difficulty,
      @HiveField(7) final int totalScore}) = _$ScoreImpl;
  _Score._() : super._();

  factory _Score.fromJson(Map<String, dynamic> json) = _$ScoreImpl.fromJson;

  @override
  @HiveField(1)
  String get id;
  @override
  @HiveField(2)
  DateTime get playedAt;
  @override
  @HiveField(3)
  String get factId;
  @override
  @HiveField(4)
  String get userId;
  @override
  @HiveField(5)
  int get score;
  @override
  @HiveField(6)
  Difficulty get difficulty;
  @override
  @HiveField(7)
  int get totalScore;
  @override
  @JsonKey(ignore: true)
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
