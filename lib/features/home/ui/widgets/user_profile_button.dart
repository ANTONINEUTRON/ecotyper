import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/data/model/user.dart';
import 'package:ecotyper/features/account/ui/pages/account_page.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AccountBloc>().state.user;

    return CustomIconButton(
      icon: user == null
          ? const Icon(
              Icons.person_2,
              color: Colors.black,
            )
          : AvatarWidget(size: 40.sp),
      onPressed: () => Navigator.push(
        context,
        AccountPage.route(),
      ),
    );
  }
}
