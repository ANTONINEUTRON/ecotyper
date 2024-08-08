import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/features/gameplay/data/model/fact.dart';
import 'package:ecotyper/features/gameplay/data/model/score.dart';
import 'package:ecotyper/features/gameplay/ui/pages/prologue_page.dart';
import 'package:ecotyper/shared/constants.dart';
import 'package:ecotyper/shared/utils/get_formatted_date.dart';
import 'package:ecotyper/shared/widgets/custom_rating.dart';

class PlayedFacts extends StatelessWidget {
  const PlayedFacts({
    super.key,
    this.scrollPhysics,
  });

  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<GameplayBloc>();
    GameplayState state = bloc.state;
    Map<Score, Fact>? scoresToFacts = state.scoreToFactsMap;

    List<Score> scores = scoresToFacts.keys.toList();
    scores.sort(
      (a, b) {
        return b.playedAt.compareTo(a.playedAt);
      },
    );

    return state.loadPlayedFactsStatus == LoadPlayedFactsStatus.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : scores.isEmpty
            ? const Center(
                child: Text("No recorded score yet!"),
              )
            : GridView.builder(
                padding: EdgeInsets.only(bottom: 16.sp),
                shrinkWrap: true,
                physics: scrollPhysics,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 170,
                  mainAxisSpacing: 4.sp,
                  crossAxisSpacing: 4.sp,
                ),
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  var score = scores[index];
                  var fact = scoresToFacts[score];

                  return GestureDetector(
                    onTap: () {
                      bloc.playOldFact(fact).then(
                        (value) {
                          Navigator.push(
                            context,
                            ProloguePage.route(),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 8.sp,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        padding: EdgeInsets.all(8.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(
                                  child: Text(
                                      "${score.score}/${score.totalScore} ${AppConstants.token}"),
                                ),
                                Text(fact!.level.title),
                              ],
                            ),
                            Text(
                              fact.fact,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getFormattedDate(dateTime: score.playedAt),
                                ),
                                CustomRatingBar(
                                  rating: score.score / score.totalScore * 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
