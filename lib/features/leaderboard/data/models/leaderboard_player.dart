import 'package:ecotyper/features/account/data/model/user.dart';

class LeaderboardPlayer {
  LeaderboardPlayer({
    required this.user,
    required this.overall,
  });

  final User user;
  final int overall;
}
