import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/timer_state.dart';

class TimerBloc extends Cubit<TimerState> {
  TimerBloc() : super(const TimerState());
  Timer? timer;

  /// This function is for starting the timer
  /// If the timer was paused previously it will play from where paused
  /// To play from pause don't pass seconds
  void start({int? seconds}) {
    seconds ??= state.duration.inSeconds;
    // if (timer == null) {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.duration.inSeconds <= 0) {
          stop();
        } else {
          emit(
            state.copyWith(
              timerStatus: TimerStatus.counting,
              duration: state.duration - const Duration(seconds: 1),
            ),
          );
        }
      },
    );
    emit(
      state.copyWith(
        timerStatus: TimerStatus.counting,
        duration: Duration(seconds: seconds),
      ),
    );
    // }
  }

  void pause() {
    timer?.cancel();
    emit(
      state.copyWith(
        timerStatus: TimerStatus.paused,
      ),
    );
  }

  void stop() {
    timer?.cancel();
    emit(
      state.copyWith(
        timerStatus: TimerStatus.initial,
        duration: Duration.zero,
      ),
    );
  }
}
