import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.g.dart';
part 'game.freezed.dart';

@freezed
class Game with _$Game {
  factory Game({
    required final String id,
    required final int level,
    required final String passage,
    required final List<String> keywords,
    required final int totalScore,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
