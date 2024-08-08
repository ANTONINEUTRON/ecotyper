import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';
import 'package:ecotyper/features/keyboard/widgets/keyboard_row.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    super.key,
    required this.onKeywordListChange,
  });

  final Function(bool isKeywordListEmpty) onKeywordListChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      padding: EdgeInsets.only(
        bottom: 32.sp,
        top: 24.sp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EnteredTextContainer(
            onKeywordListChange: onKeywordListChange,
          ),
          KeyboardRow(
            keys: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
          ),
          KeyboardRow(
            keys: ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
          ),
          KeyboardRow(
            keys: ["Z", "X", "C", "V", "B", "N", "M"],
          ),
        ],
      ),
    );
  }
}

class EnteredTextContainer extends StatelessWidget {
  const EnteredTextContainer({
    super.key,
    required this.onKeywordListChange,
  });
  final Function(bool isKeywordListEmpty) onKeywordListChange;

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<GameplayBloc>();
    var state = bloc.state;
    String enteredText = state.typedText;

    onKeywordListChange(state.score == bloc.getTotalScore());

    return Container(
      width: MediaQuery.of(context).size.width * 0.67,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2.sp,
        ),
        borderRadius: BorderRadius.circular(16.sp),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.only(
        bottom: 16.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              enteredText,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: InkWell(
                  onTap: () {
                    context.read<GameplayBloc>().clearTypedText();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
              if (state.difficulty != Difficulty.hard)
                InkWell(
                  onTap: () {
                    context.read<GameplayBloc>().removeLastCharacter();
                  },
                  child: const Icon(Icons.backspace_rounded),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
