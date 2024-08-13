import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/leaderboard/ui/widgets/score_card.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/played_facts.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class PersonalScore extends StatelessWidget {
  const PersonalScore({super.key});

  // static route() => MaterialPageRoute(
  //       builder: (context) => const ScoresPage(),
  //     );

  @override
  Widget build(BuildContext context) {
    context.read<GameplayBloc>().fetchPlayedFacts();

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.pageBg.provider(),
          fit: BoxFit.fill,
          opacity: 0.3,
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.sp),
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: CloseButton(),
          ),
          const ScoreCard(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Played Games",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SortButton(),
              ],
            ),
          ),
          const PlayedFacts(
            scrollPhysics: NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}

enum SortBy {
  date,
  score,
}

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortBy>(
      itemBuilder: (context) {
        return SortBy.values.map(
          (e) {
            return PopupMenuItem(
              value: e,
              child: Text(e.name),
            );
          },
        ).toList();
      },
      child: CustomIconButton(
        icon: const Icon(Icons.filter_alt),
      ),
    );
  }
}
