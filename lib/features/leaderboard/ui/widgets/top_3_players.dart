import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/constants.dart';

class Top3Players extends StatelessWidget {
  const Top3Players({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var players = context.read<LeaderboardBloc>().state.players;

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (players.length > 1)
            TopPlayerBar(
              posImage: Assets.images.pos3,
              name: players[1].user.name,
              score: players[1].overall.toString(),
              screenHeightPercent: 19,
              color: Color.fromARGB(255, 217, 158, 40),
            ),
          TopPlayerBar(
            posImage: Assets.images.pos1,
            name: players[0].user.name,
            score: players[0].overall.toString(),
            screenHeightPercent: 39,
            color: Color.fromARGB(255, 223, 172, 6),
          ),
          if (players.length > 2)
            TopPlayerBar(
              posImage: Assets.images.pos2,
              name: players[2].user.name,
              score: players[2].overall.toString(),
              screenHeightPercent: 28,
              color: Color.fromARGB(255, 211, 211, 211),
            ),
        ],
      ),
    );
  }
}

class TopPlayerBar extends StatelessWidget {
  const TopPlayerBar({
    super.key,
    required this.posImage,
    required this.name,
    required this.score,
    required this.screenHeightPercent,
    required this.color,
  });

  final AssetGenImage posImage;
  final String name;
  final String score;
  final int screenHeightPercent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * screenHeightPercent / 100,
      width: screenSize.width * 0.3,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Column(
        children: [
          posImage.image(
            width: 80.w,
            height: 80.h,
          ),
          Text(name),
          Text(score + " " + AppConstants.token),
        ],
      ),
    );
  }
}
