import 'package:equatable/equatable.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
import 'package:ecotyper/features/gameplay/data/model/fact.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/model/score.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';

enum LoadPlayedFactsStatus {
  loading,
  loaded,
}

enum LoadingFactStatus {
  initial,
  loading,
  successful,
  error,
}

class GameplayState extends Equatable {
  const GameplayState({
    this.typedText = "",
    this.loadPlayedFactsStatus = LoadPlayedFactsStatus.loading,
    this.keywords = const [],
    this.fact,
    this.typedWords = const [],
    this.score = 0,
    this.selectedSection,
    this.selectedLevelRange,
    this.loadingFactStatus = LoadingFactStatus.initial,
    // this.playedFacts,
    this.difficulty = Difficulty.easy,
    this.scoreToFactsMap = const {},
  });

  final String typedText;
  final LoadPlayedFactsStatus loadPlayedFactsStatus;
  final List<String> keywords;
  final List<String> typedWords;
  final LoadingFactStatus loadingFactStatus;
  final Fact? fact;
  final int score;
  final Sections? selectedSection;
  final Levels? selectedLevelRange;
  final Map<Score, Fact> scoreToFactsMap;
  final Difficulty difficulty;

  @override
  List<Object?> get props => [
        typedText,
        loadPlayedFactsStatus,
        keywords,
        typedWords,
        score,
        selectedSection,
        selectedLevelRange,
        fact,
        loadingFactStatus,
        difficulty,
        scoreToFactsMap,
      ];

  GameplayState copyWith({
    String? typedText,
    LoadPlayedFactsStatus? loadPlayedFactsStatus,
    List<String>? keywords,
    List<String>? typedWords,
    int? score,
    Sections? selectedSection,
    Levels? selectedLevelRange,
    Fact? fact,
    LoadingFactStatus? loadingFactStatus,
    Difficulty? difficulty,
    Map<Score, Fact>? scoreToFactsMap,
  }) =>
      GameplayState(
        typedText: typedText ?? this.typedText,
        loadPlayedFactsStatus:
            loadPlayedFactsStatus ?? this.loadPlayedFactsStatus,
        keywords: keywords ?? this.keywords,
        typedWords: typedWords ?? this.typedWords,
        score: score ?? this.score,
        selectedSection: selectedSection ?? this.selectedSection,
        selectedLevelRange: selectedLevelRange ?? this.selectedLevelRange,
        fact: fact ?? this.fact,
        loadingFactStatus: loadingFactStatus ?? this.loadingFactStatus,
        difficulty: difficulty ?? this.difficulty,
        scoreToFactsMap: scoreToFactsMap ?? this.scoreToFactsMap,
      );
}
