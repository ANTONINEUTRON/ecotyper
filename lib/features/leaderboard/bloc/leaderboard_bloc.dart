import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/leaderboard/data/models/leaderboard_player.dart';
import 'package:ecotyper/features/gameplay/data/repository/game_repository.dart';
import 'package:ecotyper/features/leaderboard/bloc/leaderboard_state.dart';

class LeaderboardBloc extends Cubit<LeaderboardState> {
  LeaderboardBloc({required this.gameRepository})
      : super(const LeaderboardState());

  final GameRepository gameRepository;

  Future<void> loadLeaderboard() async {
    emit(
      state.copyWith(
        leaderboardStatus: LeaderboardStatus.loading,
      ),
    );
    try {
      List<LeaderboardPlayer> players = await gameRepository.getGlobalPlayers();

      emit(
        state.copyWith(
          leaderboardStatus: LeaderboardStatus.loaded,
          players: players,
        ),
      );
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      emit(
        state.copyWith(
          leaderboardStatus: LeaderboardStatus.error,
        ),
      );
    }
  }
}
