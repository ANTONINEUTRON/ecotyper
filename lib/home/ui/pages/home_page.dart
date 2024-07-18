import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/ui/pages/account_page.dart';
import 'package:ecotyper/features/gameplay/ui/pages/select_section_page.dart';
import 'package:ecotyper/features/home/bloc/app_bloc.dart';
import 'package:ecotyper/features/home/ui/widgets/toggle_sound_button.dart';
import 'package:ecotyper/features/leaderboard/ui/pages/leaderboard_page.dart';
import 'package:ecotyper/features/preview/ui/pages/preview_page.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_button.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    var appBloc = context.watch<AppBloc>();
    var notifyMessage = appBloc.state.notifyMessage;

    if (notifyMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          //
          //Show notification as snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(notifyMessage),
            ),
          );
          //
          //clear state after 5 seconds
          Timer(
            const Duration(seconds: 5),
            () => appBloc.clearNotificationMsg(),
          );
        },
      );
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Are you sure?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text("Yes"),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.pageBg.provider(),
              fit: BoxFit.fill,
              opacity: 0.9,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Stack(
            fit: StackFit.expand,
            children: [
              //
              // Top left volume button
              Positioned(
                top: 24.h,
                left: 16.sp,
                child: const ToggleSoundButton(),
              ),
              //
              // Top right volume button
              Positioned(
                top: 24.h,
                right: 16.sp,
                child: CustomIconButton(
                  icon: const Icon(
                    Icons.person_2,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    AccountPage.route(),
                  ), //SigninPage.route()),
                ),
              ),
              //
              // Main Navigation Buttons
              Positioned(
                bottom: 170.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CustomButton(
                      text: "PLAY",
                      onTap: () => Navigator.push(
                        context,
                        SelectLevelPage.route(),
                      ),
                    ),
                    CustomButton(
                      text: "LEADERBOARD",
                      onTap: () {
                        Navigator.push(
                          context,
                          LeaderboardPage.route(),
                        );
                      },
                    ),
                    CustomButton(
                      text: "HELP",
                      onTap: () {
                        Navigator.push(
                          context,
                          PreviewPage.route(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              //
              // loading section
            ],
          ),
        ),
      ),
    );
  }
}
