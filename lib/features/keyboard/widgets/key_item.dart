import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';

class KeyItem extends StatelessWidget {
  const KeyItem({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            context.read<GameplayBloc>().keyPressed(text);
            //Play Sound
            context.read<AppBloc>().playKeyTapSFX();
          },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.sp),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: EdgeInsets.all(12.sp),
        margin: EdgeInsets.symmetric(
          horizontal: 2.sp,
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(fontSize: 18),
        ),
      ),
    );
  }
}
