import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:ecotyper/features/leaderboard/ui/widgets/top_3_players.dart';
import 'package:ecotyper/shared/constants.dart';

class GlobalLBMainUI extends StatelessWidget {
  const GlobalLBMainUI({super.key});

  @override
  Widget build(BuildContext context) {
    var players = context.read<LeaderboardBloc>().state.players;

    return players.isEmpty
        ? const Center(
            child: Text("No Leaderboard yet!"),
          )
        : ListView(
            children: [
              const Top3Players(),
              //
              // 4th - down position
              if (players.length > 3)
                Container(
                  padding: EdgeInsets.all(16.sp),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: players.length - 3,
                    itemBuilder: (context, index) {
                      var player = players[index + 3];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.sp),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                            vertical: 8.sp,
                          ),
                          tileColor: Theme.of(context).colorScheme.secondary,
                          leading: Text((index + 1).toString()),
                          title: Text(player.user.name),
                          trailing:
                              Text("${player.overall} ${AppConstants.token}"),
                          //  Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [

                          //     Text(getFormattedDate(dateTime: player.ov))
                          //   ],
                          // ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
  }
}
