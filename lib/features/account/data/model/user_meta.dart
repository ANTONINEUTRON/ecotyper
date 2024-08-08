import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';

part 'user_meta.g.dart';
part 'user_meta.freezed.dart';

@freezed
class UserMeta extends HiveObject with _$UserMeta {
  UserMeta._();

  @HiveType(typeId: 6)
  factory UserMeta({
    /// This variable helps with level unlocking for user
    /// A new shouldn't be able to play more than level one
    @HiveField(1) @Default([Levels.level_1]) List<Levels> accessibleLevels,

    /// For keeping track of user selecte difficulty
    @HiveField(2) @Default(Difficulty.easy) Difficulty selectedDifficulty,
  }) = _UserMeta;

  factory UserMeta.fromJson(Map<String, dynamic> json) =>
      _$UserMetaFromJson(json);
  //  @override
  //  Map<String, dynamic> toJson() => _$$UserMetaImplToJson(this);
}
