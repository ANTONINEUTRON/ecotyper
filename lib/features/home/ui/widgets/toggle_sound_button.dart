import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_state.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class ToggleSoundButton extends StatefulWidget {
  const ToggleSoundButton({
    super.key,
  });

  @override
  State<ToggleSoundButton> createState() => _ToggleSoundButtonState();
}

class _ToggleSoundButtonState extends State<ToggleSoundButton> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<AppBloc>();
    var playMusicStatus = bloc.state.playMusicStatus;
    bool isSoundOn = playMusicStatus == PlayMusicStatus.play;

    return CustomIconButton(
      icon: Icon(
        isSoundOn ? Icons.volume_up : Icons.volume_off,
        color: Colors.black,
      ),
      onPressed: () {
        if (isSoundOn) {
          bloc.stopMusic();
          print("stopped");
        } else {
          bloc.playMusic();
          print("played");
        }
      },
    );
  }
}
