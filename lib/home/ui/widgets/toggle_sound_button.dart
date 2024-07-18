import 'package:flutter/material.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class ToggleSoundButton extends StatefulWidget {
  const ToggleSoundButton({
    super.key,
  });

  @override
  State<ToggleSoundButton> createState() => _ToggleSoundButtonState();
}

class _ToggleSoundButtonState extends State<ToggleSoundButton> {
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Icon(
        isSoundOn ? Icons.volume_up : Icons.volume_off,
        color: Colors.black,
      ),
      onPressed: () {
        setState(() {
          isSoundOn = !isSoundOn;
        });
      },
    );
  }
}
