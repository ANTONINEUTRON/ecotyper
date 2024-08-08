import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_state.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/game_over_section_body.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const GameOverPage(),
      );

  @override
  Widget build(BuildContext context) {
    _checkIfToPlayMusic(context);

    var bloc = context.read<GameplayBloc>();

    // Save score
    bloc.saveScore();

    // Save fact to localstorage
    bloc.savePlayedFact();

    // update level the user played
    context
        .read<AccountBloc>()
        .unlockNextLevel(levelPlayed: bloc.state.fact!.level);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.gameplayBg.provider(),
              fit: BoxFit.fill,
              opacity: 0.7,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: GameOverSectionBody(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Assets.images.buttonBg.provider(),
                      ),
                    ),
                    padding: EdgeInsets.all(40.sp),
                    child: Text(
                      "GAME OVER",
                      style: TextStyle(fontSize: 48.sp, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkIfToPlayMusic(BuildContext context) {
    // Resume Playing music
    var bloc = context.read<AppBloc>();
    if (bloc.state.playMusicStatus != PlayMusicStatus.stopped) {
      bloc.playMusic();
    }
  }
}
