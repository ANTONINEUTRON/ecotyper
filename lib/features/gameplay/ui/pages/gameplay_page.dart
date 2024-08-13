import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/timer_bloc.dart';
import 'package:ecotyper/features/gameplay/ui/dialogs/pause_dialog.dart';
import 'package:ecotyper/features/gameplay/ui/pages/game_over_page.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/cloud_item.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/gameplay_timer.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/score_board.dart';
import 'package:ecotyper/features/keyboard/widgets/custom_keyboard.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_button.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class GameplayPage extends StatefulWidget {
  const GameplayPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const GameplayPage(),
      );

  @override
  State<GameplayPage> createState() => _GameplayPageState();
}

class _GameplayPageState extends State<GameplayPage> {
  late AnimationController animationController;

  void showEndGameDialog() {
    var bloc = context.read<GameplayBloc>();

    Timer(
      const Duration(seconds: 1),
      () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          animationController.stop();
          return AlertDialog(
            content: bloc.state.score != bloc.getTotalScore()
                ? const GameOverDialog()
                : const GameWonDialog(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    animationController.stop();
    // animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var gamePlayBloc = context.read<GameplayBloc>();
    List<String> keywords = gamePlayBloc.state.keywords;

    var fact = gamePlayBloc.state.fact;
    var fallTime = fact!.level.easyTimeToCompleteFall *
        gamePlayBloc.state.difficulty.speed;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showPauseDialog(context);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.gameplayBg.provider(),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.66,
                    // width: MediaQuery.of(context).size.width * 0.99,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Wrap(
                          children: keywords
                              .map(
                                (keyword) => CloudItem(
                                  key: Key(keyword),
                                  text: keyword,
                                ),
                              )
                              .toList(),
                        ).animate(
                          onInit: (controller) {
                            animationController = controller;
                          },
                          onComplete: (controller) {
                            showEndGameDialog();
                          },
                        ).slideY(
                          duration: Duration(seconds: fallTime.toInt()),
                          begin: -1.0,
                          end: fact.level.endPosition,
                        )
                      ],
                    ),
                  ),
                  //Timer Button
                  Positioned(
                    top: 24.h,
                    left: 8.w,
                    child: Builder(builder: (context) {
                      return GameplayTimer(
                        seconds: fallTime.toInt(),
                      );
                    }),
                  ),
                  // Score Holder
                  const Align(
                    alignment: Alignment.topCenter,
                    child: ScoreBoard(),
                  ),
                  //Pause Button
                  Positioned(
                    top: 24.h,
                    right: 8.w,
                    child: CustomIconButton(
                      onPressed: () {
                        showPauseDialog(context);
                      },
                      icon: const Icon(
                        Icons.pause_circle_filled_outlined,
                      ),
                    ),
                  )
                ],
              ),
              FittedBox(
                child: CustomKeyboard(
                  onKeywordListChange: (isKeywordListEmpty) {
                    if (isKeywordListEmpty &&
                        !animationController.isCompleted) {
                      showEndGameDialog();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showPauseDialog(BuildContext context) {
    context.read<TimerBloc>().pause();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: PauseDialog(
            animationController: animationController,
          ),
        );
      },
    );
  }
}

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Play Winning Sound
    context.read<AppBloc>().playGameOverSFX();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomButton(
          text: "GAME OVER!",
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);

            Navigator.pushReplacement(
              context,
              GameOverPage.route(),
            );
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}

class GameWonDialog extends StatelessWidget {
  const GameWonDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Play Winning Sound
    context.read<AppBloc>().playGameWonSFX();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.images.winnerTrophy.image(
          height: 160,
          width: 160,
        ),
        const CustomButton(
          text: "YOU WON!!!",
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);

            Navigator.pushReplacement(
              context,
              GameOverPage.route(),
            );
          },
          child: const Text("Continue"),
        ),
      ],
    );
  }
}
