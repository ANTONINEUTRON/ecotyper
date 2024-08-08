import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
part 'score.g.dart';
part 'score.freezed.dart';

@freezed
class Score extends HiveObject with _$Score {
  Score._();

  @HiveType(typeId: 4)
  factory Score({
    @HiveField(1) required String id,
    @HiveField(2) required DateTime playedAt,
    @HiveField(3) required String factId,
    @HiveField(4) required String userId,
    @HiveField(5) required int score,
    @HiveField(6) required Difficulty difficulty,
    @HiveField(7) @Default(100) int totalScore,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}
