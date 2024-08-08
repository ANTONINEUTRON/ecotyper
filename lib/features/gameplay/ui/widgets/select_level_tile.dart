import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/features/gameplay/data/model/levels.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class SelectLevelTile extends StatelessWidget {
  const SelectLevelTile({
    super.key,
    required this.level,
  });

  final Levels level;

  @override
  Widget build(BuildContext context) {
    var gamePlayState = context.watch<GameplayBloc>().state;
    print(context.read<AccountBloc>().getUserMeta().accessibleLevels);
    print(level);
    // var accountState = .state;
    bool isAccesible = context
        .read<AccountBloc>()
        .getUserMeta()
        .accessibleLevels
        .contains(level);

    bool isConnected = context.watch<AppBloc>().state.isConnectedToInternet;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        border: Border.all(color: Colors.black54),
        image: DecorationImage(
          image: Assets.images.pageBg.provider(),
          fit: BoxFit.fitWidth,
          opacity: 0.3,
        ),
      ),
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        // leading: if(!isAccesible) Icon(Icons.add), //show lock if not in accessibility
        title: Text(
          level.title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text("1/100"),
        trailing: !isConnected
            ? const Icon(
                Icons.signal_cellular_connected_no_internet_0_bar_rounded,
              )
            : isAccesible
                ? ElevatedButton(
                    onPressed: gamePlayState.loadingFactStatus ==
                            LoadingFactStatus.loading
                        ? null
                        : () {
                            context.read<GameplayBloc>()
                              ..setSelectedLevel(level)
                              ..generateFact();
                          },
                    child: const Text("Play"),
                  )
                : IconButton(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Play a level to unlock the next level"),
                      ),
                    ),
                    icon: Icon(Icons.lock),
                  ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
