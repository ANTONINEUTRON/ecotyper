import 'package:equatable/equatable.dart';
import 'package:ecotyper/features/leaderboard/data/models/leaderboard_player.dart';

enum LeaderboardStatus { loading, loaded, error }

class LeaderboardState extends Equatable {
  const LeaderboardState({
    this.players = const [],
    this.leaderboardStatus = LeaderboardStatus.loading,
  });

  final List<LeaderboardPlayer> players;
  final LeaderboardStatus leaderboardStatus;

  @override
  List<Object?> get props => [
        players,
        leaderboardStatus,
      ];

  LeaderboardState copyWith({
    List<LeaderboardPlayer>? players,
    LeaderboardStatus? leaderboardStatus,
  }) {
    return LeaderboardState(
      players: players ?? this.players,
      leaderboardStatus: leaderboardStatus ?? this.leaderboardStatus,
    );
  }
}
