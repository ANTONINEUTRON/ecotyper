import 'package:ecotyper/features/account/ui/pages/profile_page.dart';
import 'package:ecotyper/features/account/ui/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/data/model/user.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AccountBloc>().state.user;

    return user == null
        ? CustomIconButton(
            icon: const Icon(
              Icons.person_2,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(
              context,
              SigninPage.route(),
            ),
          )
        : GestureDetector(
            onTap: () => Navigator.push(
              context,
              ProfilePage.route(),
            ),
            child: const CircleAvatar(
              child: AvatarWidget(size: 45),
            ),
          );
  }
}
