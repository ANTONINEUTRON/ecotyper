import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/highlighted_passage.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class FactCard extends StatelessWidget {
  const FactCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GameplayState state = context.read<GameplayBloc>().state;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        image: DecorationImage(
          image: Assets.images.alternativeBg.provider(),
          fit: BoxFit.fill,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(32.sp),
      margin: EdgeInsets.symmetric(vertical: 16.sp),
      child: Column(
        children: [
          HighlightedPassage(
            passage: state.fact?.fact ?? "",
            wordsToHighlight: state.keywords,
          ),
        ],
      ),
    );
  }
}
