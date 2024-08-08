import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ecotyper/features/app/data/repository/app_repository.dart';
import 'package:ecotyper/features/gameplay/data/repository/game_repository.dart';
import 'package:ecotyper/features/app/bloc/app_state.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/utils/check_for_internet.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc({
    required this.appRepository,
    required this.gameRepository,
  }) : super(const AppState()) {
    initializeInternetCheck();
    //
    //
    //Initialize music play
    initializeMusicPlay();
  }

  final AppRepository appRepository;
  final GameRepository gameRepository;
  final _player = AudioPlayer();
  final _sfxPlayer = AudioPlayer();

  void initializeMusicPlay() {
    appRepository.getToPlayMusic().then(
      (value) {
        if (value) {
          playMusic();
        } else {
          stopMusic();
        }
      },
    );
  }

  void initializeInternetCheck() async {
    Stream.periodic(
      const Duration(seconds: 5),
      (computationCount) async {
        return await checkForInternetConnection();
      },
    ).listen((event) async {
      emit(
        state.copyWith(
          isConnectedToInternet: await event,
        ),
      );
    });
  }

  void notifyUser(String message) async {
    emit(
      state.copyWith(notifyMessage: message),
    );
    Timer(
      Duration(seconds: 15),
      () => _clearNotificationMsg,
    );
  }

  void _clearNotificationMsg() async {
    emit(
      state.copyWith(notifyMessage: null),
    );
  }

  void playMusic() async {
    await _player.setAsset(Assets.audio.normal);
    _player.setLoopMode(LoopMode.one);
    _player.play();

    emit(
      state.copyWith(playMusicStatus: PlayMusicStatus.play),
    );
    //save to repository
    appRepository.setToPlayMusic(true);
  }

  void stopMusic() async {
    // pauseMusic();
    _player.pause();

    emit(
      state.copyWith(playMusicStatus: PlayMusicStatus.stopped),
    );
    //save to repository
    appRepository.setToPlayMusic(false);
  }

  void pauseMusic() async {
    _player.pause();

    emit(
      state.copyWith(playMusicStatus: PlayMusicStatus.pause),
    );
  }

  void playCloudClearedSFX() async {
    //return if the user turned off sfx
    if (!state.sfxToPlay) return;

    await _sfxPlayer.setAsset(Assets.audio.cloudCleared);
    _sfxPlayer.play();
  }

  void playKeyTapSFX() async {
    //return if the user turned off sfx
    if (!state.sfxToPlay) return;

    await _sfxPlayer.setAsset(Assets.audio.gameKeyTap);
    _sfxPlayer.play();
  }

  void playGameOverSFX() async {
    //return if the user turned off sfx
    if (!state.sfxToPlay) return;

    await _sfxPlayer.setAsset(Assets.audio.gameOver);
    _sfxPlayer.play();
  }

  void playGameWonSFX() async {
    //return if the user turned off sfx
    if (!state.sfxToPlay) return;

    await _sfxPlayer.setAsset(Assets.audio.gameWon);
    _sfxPlayer.play();
  }

  void playLoadGameSFX() async {
    //return if the user turned off sfx
    if (!state.sfxToPlay) return;

    await _sfxPlayer.setAsset(Assets.audio.load);
    _sfxPlayer.play();
  }

  void toggleSfx() async {
    emit(
      state.copyWith(sfxToPlay: !state.sfxToPlay),
    );
  }
}
