import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/data/model/user.dart';

class ProfileDetailsSection extends StatelessWidget {
  const ProfileDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User user = context.watch<AccountBloc>().state.user!;
    return Container(
      margin: EdgeInsets.only(top: 28.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(20, 30),
          topRight: Radius.elliptical(20, 50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user.name,
            style: TextStyle(
              fontSize: 32.sp,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.email),
              SizedBox(
                width: 4.w,
              ),
              user.isVerified
                  ? const Icon(
                      Icons.verified,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.person_off,
                      color: Colors.red,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
