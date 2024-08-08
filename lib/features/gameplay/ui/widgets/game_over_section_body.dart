import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/ui/pages/select_level_page.dart';
import 'package:ecotyper/features/gameplay/ui/pages/select_section_page.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/fact_card.dart';
import 'package:ecotyper/features/leaderboard/ui/pages/leaderboard_page.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/score_view.dart';
import 'package:ecotyper/features/home/ui/pages/home_page.dart';

class GameOverSectionBody extends StatelessWidget {
  const GameOverSectionBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<GameplayBloc>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        top: 32.sp,
        bottom: 16.sp,
        right: 16.sp,
        left: 16.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.sp),
          topRight: Radius.circular(24.sp),
        ),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Score container for showing user score
            const ScoreView(),
            //
            // Show Facts and Its prologue
            const FactCard(),
            //
            //
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomRectButton(
                  text: "PLAY AGAIN",
                  onTap: () {
                    bloc.playAgain();
                    Navigator.pushReplacement(
                      context,
                      SelectLevelPage.route(),
                    );
                  },
                ),
                CustomRectButton(
                  text: "LEADERBOARD",
                  onTap: () {
                    bloc.resetState();
                    Navigator.pushReplacement(
                      context,
                      LeaderboardPage.route(),
                    );
                  },
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomRectButton(
                        text: "SECTIONS",
                        onTap: () {
                          bloc.resetState();
                          Navigator.pushReplacement(
                            context,
                            SelectSectionPage.route(),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 4.sp,
                    ),
                    Flexible(
                      child: CustomRectButton(
                        text: "HOME",
                        onTap: () {
                          bloc.resetState();
                          Navigator.pushReplacement(
                            context,
                            HomePage.route(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
