// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserMeta _$UserMetaFromJson(Map<String, dynamic> json) {
  return _UserMeta.fromJson(json);
}

/// @nodoc
mixin _$UserMeta {
  /// This variable helps with level unlocking for user
  /// A new shouldn't be able to play more than level one
  @HiveField(1)
  List<Levels> get accessibleLevels => throw _privateConstructorUsedError;

  /// For keeping track of user selecte difficulty
  @HiveField(2)
  Difficulty get selectedDifficulty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserMetaCopyWith<UserMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMetaCopyWith<$Res> {
  factory $UserMetaCopyWith(UserMeta value, $Res Function(UserMeta) then) =
      _$UserMetaCopyWithImpl<$Res, UserMeta>;
  @useResult
  $Res call(
      {@HiveField(1) List<Levels> accessibleLevels,
      @HiveField(2) Difficulty selectedDifficulty});
}

/// @nodoc
class _$UserMetaCopyWithImpl<$Res, $Val extends UserMeta>
    implements $UserMetaCopyWith<$Res> {
  _$UserMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessibleLevels = null,
    Object? selectedDifficulty = null,
  }) {
    return _then(_value.copyWith(
      accessibleLevels: null == accessibleLevels
          ? _value.accessibleLevels
          : accessibleLevels // ignore: cast_nullable_to_non_nullable
              as List<Levels>,
      selectedDifficulty: null == selectedDifficulty
          ? _value.selectedDifficulty
          : selectedDifficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMetaImplCopyWith<$Res>
    implements $UserMetaCopyWith<$Res> {
  factory _$$UserMetaImplCopyWith(
          _$UserMetaImpl value, $Res Function(_$UserMetaImpl) then) =
      __$$UserMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(1) List<Levels> accessibleLevels,
      @HiveField(2) Difficulty selectedDifficulty});
}

/// @nodoc
class __$$UserMetaImplCopyWithImpl<$Res>
    extends _$UserMetaCopyWithImpl<$Res, _$UserMetaImpl>
    implements _$$UserMetaImplCopyWith<$Res> {
  __$$UserMetaImplCopyWithImpl(
      _$UserMetaImpl _value, $Res Function(_$UserMetaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessibleLevels = null,
    Object? selectedDifficulty = null,
  }) {
    return _then(_$UserMetaImpl(
      accessibleLevels: null == accessibleLevels
          ? _value._accessibleLevels
          : accessibleLevels // ignore: cast_nullable_to_non_nullable
              as List<Levels>,
      selectedDifficulty: null == selectedDifficulty
          ? _value.selectedDifficulty
          : selectedDifficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 6)
class _$UserMetaImpl extends _UserMeta {
  _$UserMetaImpl(
      {@HiveField(1)
      final List<Levels> accessibleLevels = const [Levels.level_1],
      @HiveField(2) this.selectedDifficulty = Difficulty.easy})
      : _accessibleLevels = accessibleLevels,
        super._();

  factory _$UserMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMetaImplFromJson(json);

  /// This variable helps with level unlocking for user
  /// A new shouldn't be able to play more than level one
  final List<Levels> _accessibleLevels;

  /// This variable helps with level unlocking for user
  /// A new shouldn't be able to play more than level one
  @override
  @JsonKey()
  @HiveField(1)
  List<Levels> get accessibleLevels {
    if (_accessibleLevels is EqualUnmodifiableListView)
      return _accessibleLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accessibleLevels);
  }

  /// For keeping track of user selecte difficulty
  @override
  @JsonKey()
  @HiveField(2)
  final Difficulty selectedDifficulty;

  @override
  String toString() {
    return 'UserMeta(accessibleLevels: $accessibleLevels, selectedDifficulty: $selectedDifficulty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMetaImpl &&
            const DeepCollectionEquality()
                .equals(other._accessibleLevels, _accessibleLevels) &&
            (identical(other.selectedDifficulty, selectedDifficulty) ||
                other.selectedDifficulty == selectedDifficulty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_accessibleLevels),
      selectedDifficulty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMetaImplCopyWith<_$UserMetaImpl> get copyWith =>
      __$$UserMetaImplCopyWithImpl<_$UserMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMetaImplToJson(
      this,
    );
  }
}

abstract class _UserMeta extends UserMeta {
  factory _UserMeta(
      {@HiveField(1) final List<Levels> accessibleLevels,
      @HiveField(2) final Difficulty selectedDifficulty}) = _$UserMetaImpl;
  _UserMeta._() : super._();

  factory _UserMeta.fromJson(Map<String, dynamic> json) =
      _$UserMetaImpl.fromJson;

  @override

  /// This variable helps with level unlocking for user
  /// A new shouldn't be able to play more than level one
  @HiveField(1)
  List<Levels> get accessibleLevels;
  @override

  /// For keeping track of user selecte difficulty
  @HiveField(2)
  Difficulty get selectedDifficulty;
  @override
  @JsonKey(ignore: true)
  _$$UserMetaImplCopyWith<_$UserMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
