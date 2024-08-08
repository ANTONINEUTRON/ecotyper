import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:ecotyper/features/leaderboard/bloc/leaderboard_state.dart';
import 'package:ecotyper/features/leaderboard/ui/widgets/global_leaderboard_main_ui.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class GlobalLeaderboard extends StatefulWidget {
  const GlobalLeaderboard({super.key});

  // static route() => MaterialPageRoute(
  //       builder: (context) => const GlobalLeaderboard(),
  //     );

  @override
  State<GlobalLeaderboard> createState() => _GlobalLeaderboardState();
}

class _GlobalLeaderboardState extends State<GlobalLeaderboard> {
  @override
  void initState() {
    context.read<LeaderboardBloc>().loadLeaderboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    LeaderboardState leaderboardState = context.watch<LeaderboardBloc>().state;

    Widget mainUI = const Center(
      child: CircularProgressIndicator(),
    );

    switch (leaderboardState.leaderboardStatus) {
      case LeaderboardStatus.loading:
        break;
      case LeaderboardStatus.loaded:
        mainUI = const GlobalLBMainUI();
        break;
      case LeaderboardStatus.error:
        // Error Ui to be shown to the user
        mainUI = const Center(
          child: Text("An Error Occured\nCheck your network"),
        );
        break;
    }

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.pageBg.provider(),
          opacity: 0.4,
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 16.sp),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const CloseButton(),
            //       Expanded(
            //         child: Center(
            //           child: Text(
            //             "LeaderBoard",
            //             style: TextStyle(fontSize: 24.sp),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //
            Expanded(
              child: mainUI,
            ),
          ],
        ),
      ),
    );
  }
}
