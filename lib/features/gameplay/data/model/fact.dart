import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';

part 'fact.freezed.dart';
part 'fact.g.dart';

@freezed
class Fact extends HiveObject with _$Fact {
  Fact._();

  @HiveType(typeId: 1)
  factory Fact({
    @HiveField(1) required String id,
    @HiveField(2) required String fact,
    @HiveField(3) required String prologue,
    @HiveField(4) required Section section,
    @HiveField(5) required Levels level,
    @HiveField(6) required DateTime lastAccessedTime,
  }) = _Fact;

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);
}
