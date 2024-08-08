import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.onCompleteText,
  });

  final String text;
  final Function()? onCompleteText;

  @override
  Widget build(BuildContext context) {
    String enteredText = context.watch<GameplayBloc>().state.typedText;
    String greenText = "";
    String redText = "";
    if (text.startsWith(enteredText)) {
      redText = text.replaceFirst(enteredText, "");
      greenText = enteredText;
    } else {
      redText = text;
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (onCompleteText != null && redText.isEmpty && greenText.isNotEmpty) {
          onCompleteText!();
        }
      },
    );
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: greenText,
          style: TextStyle(color: Colors.green),
        ),
        TextSpan(
          text: redText,
          style: TextStyle(color: Colors.red),
        ),
      ]),
    );
  }
}
