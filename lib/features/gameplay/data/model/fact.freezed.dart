// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Fact _$FactFromJson(Map<String, dynamic> json) {
  return _Fact.fromJson(json);
}

/// @nodoc
mixin _$Fact {
  @HiveField(1)
  String get id => throw _privateConstructorUsedError;
  @HiveField(2)
  String get fact => throw _privateConstructorUsedError;
  @HiveField(3)
  String get prologue => throw _privateConstructorUsedError;
  @HiveField(4)
  Sections get section => throw _privateConstructorUsedError;
  @HiveField(5)
  Levels get level => throw _privateConstructorUsedError;
  @HiveField(6)
  DateTime get lastAccessedTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FactCopyWith<Fact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FactCopyWith<$Res> {
  factory $FactCopyWith(Fact value, $Res Function(Fact) then) =
      _$FactCopyWithImpl<$Res, Fact>;
  @useResult
  $Res call(
      {@HiveField(1) String id,
      @HiveField(2) String fact,
      @HiveField(3) String prologue,
      @HiveField(4) Sections section,
      @HiveField(5) Levels level,
      @HiveField(6) DateTime lastAccessedTime});
}

/// @nodoc
class _$FactCopyWithImpl<$Res, $Val extends Fact>
    implements $FactCopyWith<$Res> {
  _$FactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fact = null,
    Object? prologue = null,
    Object? section = null,
    Object? level = null,
    Object? lastAccessedTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fact: null == fact
          ? _value.fact
          : fact // ignore: cast_nullable_to_non_nullable
              as String,
      prologue: null == prologue
          ? _value.prologue
          : prologue // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as Sections,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Levels,
      lastAccessedTime: null == lastAccessedTime
          ? _value.lastAccessedTime
          : lastAccessedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FactImplCopyWith<$Res> implements $FactCopyWith<$Res> {
  factory _$$FactImplCopyWith(
          _$FactImpl value, $Res Function(_$FactImpl) then) =
      __$$FactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(1) String id,
      @HiveField(2) String fact,
      @HiveField(3) String prologue,
      @HiveField(4) Sections section,
      @HiveField(5) Levels level,
      @HiveField(6) DateTime lastAccessedTime});
}

/// @nodoc
class __$$FactImplCopyWithImpl<$Res>
    extends _$FactCopyWithImpl<$Res, _$FactImpl>
    implements _$$FactImplCopyWith<$Res> {
  __$$FactImplCopyWithImpl(_$FactImpl _value, $Res Function(_$FactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fact = null,
    Object? prologue = null,
    Object? section = null,
    Object? level = null,
    Object? lastAccessedTime = null,
  }) {
    return _then(_$FactImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fact: null == fact
          ? _value.fact
          : fact // ignore: cast_nullable_to_non_nullable
              as String,
      prologue: null == prologue
          ? _value.prologue
          : prologue // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as Sections,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as Levels,
      lastAccessedTime: null == lastAccessedTime
          ? _value.lastAccessedTime
          : lastAccessedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1)
class _$FactImpl extends _Fact {
  _$FactImpl(
      {@HiveField(1) required this.id,
      @HiveField(2) required this.fact,
      @HiveField(3) required this.prologue,
      @HiveField(4) required this.section,
      @HiveField(5) required this.level,
      @HiveField(6) required this.lastAccessedTime})
      : super._();

  factory _$FactImpl.fromJson(Map<String, dynamic> json) =>
      _$$FactImplFromJson(json);

  @override
  @HiveField(1)
  final String id;
  @override
  @HiveField(2)
  final String fact;
  @override
  @HiveField(3)
  final String prologue;
  @override
  @HiveField(4)
  final Sections section;
  @override
  @HiveField(5)
  final Levels level;
  @override
  @HiveField(6)
  final DateTime lastAccessedTime;

  @override
  String toString() {
    return 'Fact(id: $id, fact: $fact, prologue: $prologue, section: $section, level: $level, lastAccessedTime: $lastAccessedTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fact, fact) || other.fact == fact) &&
            (identical(other.prologue, prologue) ||
                other.prologue == prologue) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lastAccessedTime, lastAccessedTime) ||
                other.lastAccessedTime == lastAccessedTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, fact, prologue, section, level, lastAccessedTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FactImplCopyWith<_$FactImpl> get copyWith =>
      __$$FactImplCopyWithImpl<_$FactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FactImplToJson(
      this,
    );
  }
}

abstract class _Fact extends Fact {
  factory _Fact(
      {@HiveField(1) required final String id,
      @HiveField(2) required final String fact,
      @HiveField(3) required final String prologue,
      @HiveField(4) required final Sections section,
      @HiveField(5) required final Levels level,
      @HiveField(6) required final DateTime lastAccessedTime}) = _$FactImpl;
  _Fact._() : super._();

  factory _Fact.fromJson(Map<String, dynamic> json) = _$FactImpl.fromJson;

  @override
  @HiveField(1)
  String get id;
  @override
  @HiveField(2)
  String get fact;
  @override
  @HiveField(3)
  String get prologue;
  @override
  @HiveField(4)
  Sections get section;
  @override
  @HiveField(5)
  Levels get level;
  @override
  @HiveField(6)
  DateTime get lastAccessedTime;
  @override
  @JsonKey(ignore: true)
  _$$FactImplCopyWith<_$FactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
