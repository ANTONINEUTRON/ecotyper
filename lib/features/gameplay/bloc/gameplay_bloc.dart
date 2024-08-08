import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/account/data/repository/account_repository.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
import 'package:ecotyper/features/gameplay/data/model/fact.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/data/model/score.dart';
import 'package:ecotyper/features/gameplay/data/model/sections.dart';
import 'package:ecotyper/features/gameplay/data/repository/game_repository.dart';
import 'package:uuid/uuid.dart';

class GameplayBloc extends Cubit<GameplayState> {
  GameplayBloc({
    required this.gameRepository,
  }) : super(const GameplayState());

  final GameRepository gameRepository;

  void resetState() {
    emit(const GameplayState());
  }

  void playAgain() {
    emit(
      GameplayState(
        selectedSection: state.selectedSection,
        difficulty: state.difficulty,
        scoreToFactsMap: state.scoreToFactsMap,
        loadPlayedFactsStatus: LoadPlayedFactsStatus.loaded,
      ),
    );
    fetchPlayedFacts();
  }

  void keyPressed(String text) async {
    emit(
      state.copyWith(typedText: state.typedText + text),
    );
  }

  void incrementScore({required int toAdd}) {
    emit(
      state.copyWith(
        score: state.score + toAdd,
      ),
    );
  }

  void setSelectedSection(Sections section) async {
    //
    emit(
      state.copyWith(
        selectedSection: section,
      ),
    );

    // Fetch the scoreand fetch map for the selected section
    await fetchPlayedFacts();
  }

  void setSelectedLevel(Levels level) async {
    emit(
      state.copyWith(
        selectedLevelRange: level,
      ),
    );
  }

  /// Save play fact to localstorage and refresh List of played facts in state
  void savePlayedFact() async {
    await gameRepository.saveFactsToLocalStorage(
      fact: state.fact!.copyWith(
        lastAccessedTime: DateTime.now(),
      ),
    );
  }

  void saveGenFactToRemote() async {
    try {
      gameRepository.saveFactToDB(fact: state.fact!);
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
  }

  Future<void> fetchPlayedFacts() async {
    emit(
      state.copyWith(loadPlayedFactsStatus: LoadPlayedFactsStatus.loading),
    );
    Map<Score, Fact> scoreToFactsMap = await gameRepository.fetchPlayedFacts(
      section: state.selectedSection,
    );
    emit(
      state.copyWith(
        scoreToFactsMap: scoreToFactsMap,
        loadPlayedFactsStatus: LoadPlayedFactsStatus.loaded,
      ),
    );
  }

  /// Generate a new fact from AI and return to the user to play
  void generateFact() async {
    //emit loading fact state
    emit(
      state.copyWith(
        loadingFactStatus: LoadingFactStatus.loading,
      ),
    );
    try {
      // Get facts
      Fact fact = await gameRepository.generateFact(
        section: state.selectedSection!,
        levels: state.selectedLevelRange!,
      );
      emit(
        state.copyWith(
          fact: fact,
        ),
      );
      // Get list words from fact
      List<String> keywords = _getKeywordsFromFact(fact: fact);

      //emit
      emit(
        state.copyWith(
          loadingFactStatus: LoadingFactStatus.successful,
          keywords: keywords,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          loadingFactStatus: LoadingFactStatus.error,
        ),
      );
    }
  }

  void initializeLoadingFactState() {
    emit(
      state.copyWith(
        loadingFactStatus: LoadingFactStatus.initial,
        difficulty: state.difficulty,
      ),
    );
  }

  // Take a fact and randomly get words that the user will play against
  List<String> _getKeywordsFromFact({required Fact fact}) {
    //Split word into a list
    List<String> words =
        fact.fact.replaceAll(",", "").replaceAll(".", "").split(' ');
    // Remove words with punctuations
    final punctuationRegExp = RegExp(r'^[a-zA-Z]+(?<!\W)$');
    words = words
        .where((word) => punctuationRegExp.hasMatch(word) && !(word.length < 3))
        .toList();
    // shuffle words
    words.shuffle();
    // remove duplicates
    words = words.toSet().toList();
    // remove specific numbers of words based on level length
    var wordPlayLength = state.fact!.level.wordPlayLength;
    words =
        words.sublist(0, wordPlayLength > words.length ? null : wordPlayLength);
    // sort list of words
    words.sort((a, b) => a.length.compareTo(b.length));
    return words.reversed.toList();
  }

  Future<void> playOldFact(Fact fact) async {
    //
    emit(
      state.copyWith(
        fact: fact,
      ),
    );

    // Get list words from fact
    List<String> keywords = _getKeywordsFromFact(fact: fact);

    //emit
    emit(
      state.copyWith(
        loadingFactStatus: LoadingFactStatus.successful,
        keywords: keywords,
      ),
    );
  }

  int getTotalScore() {
    var totalScore = 0;
    for (var word in state.keywords) {
      totalScore += word.length;
    }
    return totalScore;
  }

  void setDifficulty(Difficulty difficulty) {
    emit(
      state.copyWith(difficulty: difficulty),
    );
  }

  void resetLoadingFactStatus() async => emit(
        state.copyWith(
          loadingFactStatus: LoadingFactStatus.initial,
        ),
      );

  void saveScore() async {
    // If it is not the highest for the played game
    if (!shouldSaveScore()) return;

    unawaited(
      gameRepository.saveScore(
        Score(
          id: const Uuid().v4(),
          playedAt: DateTime.now(),
          factId: state.fact!.id,
          userId: (await AccountRepository().getSignedUser())?.id ?? "",
          score: state.score,
          difficulty: state.difficulty,
          totalScore: getTotalScore(),
        ),
      ),
    );
  }

  void clearTypedText() {
    emit(
      state.copyWith(typedText: ""),
    );
  }

  void removeLastCharacter() {
    var text = state.typedText;
    if (text.isNotEmpty) {
      var newText = text.substring(0, text.length - 1);
      emit(state.copyWith(typedText: newText));
    }
  }

  /// This flag control if a score should be saved based on user previous performance
  bool shouldSaveScore() {
    if (!isAnAlreadyPlayedFact()) return true;

    int previousScore = state.scoreToFactsMap.keys
        .firstWhere((scr) => scr.factId == state.fact!.id)
        .score;

    if (state.score > previousScore) {
      return true;
    } else {
      return false;
    }
  }

  bool isAnAlreadyPlayedFact() =>
      state.fact != null && state.selectedLevelRange == null;
}
