import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/shared/constants.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<GameplayBloc>();
    var state = bloc.state;
    var score = state.score;
    var totalScore = bloc.getTotalScore();

    return Container(
      margin: EdgeInsets.only(top: 32.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(20, 30),
          topRight: Radius.elliptical(20, 50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SCORE",
            style: TextStyle(
              fontSize: 32.sp,
            ),
          ),
          Text("$score/$totalScore ${AppConstants.token}")
        ],
      ),
    );
  }
}
