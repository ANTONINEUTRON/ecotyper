import 'package:equatable/equatable.dart';

enum PlayMusicStatus { play, pause, stopped }

class AppState extends Equatable {
  const AppState({
    this.playMusicStatus = PlayMusicStatus.stopped,
    this.isConnectedToInternet = false,
    this.notifyMessage,
    this.sfxToPlay = true,
  });
  final PlayMusicStatus playMusicStatus;
  final bool isConnectedToInternet;
  final String? notifyMessage;
  final bool sfxToPlay;

  @override
  List<Object?> get props => [
        playMusicStatus,
        isConnectedToInternet,
        notifyMessage,
        sfxToPlay,
      ];

  AppState copyWith({
    PlayMusicStatus? playMusicStatus,
    bool? isConnectedToInternet,
    String? notifyMessage,
    bool? sfxToPlay,
  }) {
    return AppState(
      playMusicStatus: playMusicStatus ?? this.playMusicStatus,
      isConnectedToInternet:
          isConnectedToInternet ?? this.isConnectedToInternet,
      notifyMessage: notifyMessage,
      sfxToPlay: sfxToPlay ?? this.sfxToPlay,
    );
  }
}
