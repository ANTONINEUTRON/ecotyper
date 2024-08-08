import 'package:equatable/equatable.dart';

enum TimerStatus { initial, counting, stopped, paused }

class TimerState extends Equatable {
  const TimerState({
    this.seconds = 0,
    this.timerStatus = TimerStatus.initial,
    this.duration = Duration.zero,
  });

  final int seconds;
  final TimerStatus timerStatus;
  final Duration duration;

  @override
  List<Object?> get props => [
        seconds,
        timerStatus,
        duration,
      ];

  TimerState copyWith({
    int? seconds,
    TimerStatus? timerStatus,
    Duration? duration,
  }) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      timerStatus: timerStatus ?? this.timerStatus,
      duration: duration ?? this.duration,
    );
  }
}
