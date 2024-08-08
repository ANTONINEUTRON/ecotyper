import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/timer_bloc.dart';
import 'package:ecotyper/features/gameplay/ui/pages/game_over_page.dart';
import 'package:ecotyper/features/preview/ui/pages/preview_page.dart';
import 'package:ecotyper/shared/widgets/custom_button.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    animationController.stop();
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "RESUME",
              onTap: () {
                // Close dialog
                Navigator.pop(context);

                //Start animation
                animationController.forward();

                // resume timer
                context.read<TimerBloc>().start();
              },
            ),
            ToggleSFXButton(animationController: animationController),
            CustomButton(
              text: "HELP",
              onTap: () {
                Navigator.push(
                  context,
                  PreviewPage.route(),
                );
              },
            ),
            CustomButton(
              text: "END GAME",
              onTap: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  GameOverPage.route(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleSFXButton extends StatelessWidget {
  const ToggleSFXButton({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    var appBloc = context.watch<AppBloc>();

    return CustomButton(
      text: "SOUND",
      icon: Icon(
        appBloc.state.sfxToPlay ? Icons.volume_up : Icons.volume_off,
        color: Theme.of(context).colorScheme.secondary,
        size: 35.sp,
      ),
      onTap: () {
        // Turn off sound
        appBloc.toggleSfx();
      },
    );
  }
}
