import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninWithGoogleButton extends StatelessWidget {
  const SigninWithGoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<AccountBloc>();

    return bloc.state.accountStatus == AccountStatus.processing
        ? const CircularProgressIndicator()
        : CustomRectButton(
            text: "Google",
            onTap: () {
              bloc.signInWithGoogle();
            },
          );
  }
}
