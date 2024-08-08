import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.size,
    this.urlToBeUsed,
  });
  final double size;

  /// This field will help prevent error
  /// due to context being accessed when user is trying to share
  final String? urlToBeUsed;

  @override
  Widget build(BuildContext context) {
    String userPics = urlToBeUsed == null
        ? context.watch<AccountBloc>().state.user!.displayPics
        : urlToBeUsed!;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).disabledColor,
      ),
      width: size.w,
      height: size.h,
      clipBehavior: Clip.hardEdge,
      child: Center(
        child: userPics.isEmpty
            ? Icon(
                Icons.person,
                size: (size - 8).sp,
              )
            : CachedNetworkImage(
                imageUrl: userPics,
                width: size,
                height: size,
              ),
      ),
    );
  }
}
