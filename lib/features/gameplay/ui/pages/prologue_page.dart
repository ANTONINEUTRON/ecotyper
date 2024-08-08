import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_state.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/features/gameplay/ui/pages/gameplay_page.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_button.dart';

class ProloguePage extends StatelessWidget {
  const ProloguePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) {
          return const ProloguePage();
        },
      );

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<GameplayBloc>();
    GameplayState gamePlayState = bloc.state;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            fit: BoxFit.fill,
            opacity: 0.7,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.sp),
              color: Theme.of(context).colorScheme.secondary,
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Card(
              elevation: 32.sp,
              child: Container(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "PROLOGUE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      gamePlayState.fact?.prologue ?? "",
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Text(
                        "\nReady to play and learn more?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    CustomButton(
                      text: "Start",
                      onTap: () {
                        _checkAndPauseMusic(context);

                        // save fact to remote db
                        bloc.saveGenFactToRemote();

                        // Start game
                        Navigator.pushReplacement(
                          context,
                          GameplayPage.route(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkAndPauseMusic(BuildContext context) {
    var appBloc = context.read<AppBloc>();

    if (appBloc.state.playMusicStatus != PlayMusicStatus.stopped) {
      //pause music
      appBloc.pauseMusic();
    }
    // Play progress sound
    appBloc.playLoadGameSFX();
  }
}
