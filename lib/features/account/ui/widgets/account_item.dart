import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    super.key,
    required this.title,
    this.icon,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Icon(icon),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 18.sp),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        ),
        const Divider()
      ],
    );
  }
}
