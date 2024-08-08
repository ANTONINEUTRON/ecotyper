import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/ui/pages/profile_page.dart';
import 'package:ecotyper/features/account/ui/pages/signin_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const AccountPage(),
      );

  @override
  Widget build(BuildContext context) {
    var accountStatus = context.watch<AccountBloc>().state.accountStatus;
    return accountStatus == AccountStatus.signedIn
        ? const ProfilePage()
        : const SigninPage();
  }
}
