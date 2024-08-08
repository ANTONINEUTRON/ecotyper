import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/data/model/user_meta.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/data/model/difficulty.dart';

class SelectDifficultyDropdown extends StatelessWidget {
  const SelectDifficultyDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GameplayBloc bloc = context.watch<GameplayBloc>();

    var acctBloc = context.read<AccountBloc>();
    UserMeta userMeta = acctBloc.getUserMeta();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: DropdownButton<Difficulty>(
        onChanged: (value) {
          bloc.setDifficulty(value!);

          // This function ensure the user difficulty(preference) is set
          acctBloc.setUserSelectedDifficulty(value);
        },
        value: userMeta.selectedDifficulty,
        // value: Difficulty.easy,
        items: Difficulty.values.map((difficulty) {
          // print(difficulty);
          return DropdownMenuItem(
            key: Key(difficulty.name),
            value: difficulty,
            child: Text(difficulty.name),
          );
        }).toList(),
      ),
    );
  }
}
