import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/gameplay/ui/pages/prologue_page.dart';
import 'package:ecotyper/features/gameplay/ui/pages/select_section_page.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/played_facts.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/select_level_tile.dart';
import 'package:ecotyper/shared/widgets/close_page_icon_button.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) {
          return const SelectLevelPage();
        },
      );

  @override
  Widget build(BuildContext context) {
    context.read<GameplayBloc>().initializeLoadingFactState();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pushReplacement(
          SelectSectionPage.route(),
        );
      },
      child: const Scaffold(
        body: SafeArea(child: LevelContainer()),
      ),
    );
  }
}

class LevelContainer extends StatefulWidget {
  const LevelContainer({
    super.key,
  });

  @override
  State<LevelContainer> createState() => _LevelContainerState();
}

class _LevelContainerState extends State<LevelContainer> {
  @override
  Widget build(BuildContext context) {
    GameplayBloc gameBloc = context.read<GameplayBloc>();
    GameplayState gamePlayState = gameBloc.state;

    return DefaultTabController(
      length: 2,
      child: Container(
        margin: EdgeInsets.fromLTRB(
          16.sp,
          32.sp,
          16.sp,
          0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClosePageIconButton(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      SelectSectionPage.route(),
                    );
                  },
                ),
                Text(
                  gamePlayState.selectedSection?.title ?? "",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 16.h,
                bottom: 16.h,
              ),
              child: const TabBar(
                tabs: [
                  Tab(
                    text: "New Play",
                  ),
                  Tab(
                    text: "Previous Plays",
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ListofLevels(),
                  PlayedFacts(),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}

class ListofLevels extends StatelessWidget {
  const ListofLevels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GameplayBloc gameBloc = context.watch<GameplayBloc>();
    GameplayState gamePlayState = gameBloc.state;
    bool isConnected = context.watch<AppBloc>().state.isConnectedToInternet;
    bool showError = false;
    bool gameIsLoading = false;

    switch (gamePlayState.loadingFactStatus) {
      case LoadingFactStatus.initial:
        break;
      case LoadingFactStatus.loading:
        gameIsLoading = true;
        break;
      case LoadingFactStatus.successful:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            Navigator.pushReplacement(
              context,
              ProloguePage.route(),
            );
            gameBloc.resetLoadingFactStatus();
          },
        );

        break;
      case LoadingFactStatus.error:
        showError = true;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 16.h,
        ),
        if (showError)
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: const Text("An error occured while generating"),
          ),
        if (!isConnected)
          const Text(
            "You are not connected to the internet, turn on your network connection to continue",
            textAlign: TextAlign.center,
          ),
        SizedBox(
          height: 16.h,
        ),
        ...Levels.values.map(
          (level) => SelectLevelTile(
            level: level,
          ),
        ),
        SizedBox(
          height: 24.sp,
        ),
        //
        // show circular processing when loading ui
        if (gameIsLoading)
          const Column(
            children: [
              CircularProgressIndicator(),
              Text("Initializing game ...")
            ],
          ),
      ],
    );
  }
}
