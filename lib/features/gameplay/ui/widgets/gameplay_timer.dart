import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/bloc/timer_bloc.dart';

class GameplayTimer extends StatefulWidget {
  const GameplayTimer({
    super.key,
    required this.seconds,
  });

  final int seconds;

  @override
  State<GameplayTimer> createState() => _GameplayTimerState();
}

class _GameplayTimerState extends State<GameplayTimer> {
  // late Timer timer;
  // Duration _duration = Duration.zero;

  @override
  void initState() {
    // _duration = Duration(seconds: widget.seconds);

    context.read<TimerBloc>().start(seconds: widget.seconds);
    //
    //
    // widget.animationController?.addListener(
    //   () {
    //     print("Changed");
    //     // if (!widget.animationController.isAnimating) {
    //     //   timer.cancel();
    //     // }
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<TimerBloc>().state;

    var duration = state.duration;

    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      padding: EdgeInsets.all(8.sp),
      child: Text(
        '$minutes:$seconds',
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
