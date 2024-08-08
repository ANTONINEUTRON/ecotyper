import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class FactCardToShare extends StatelessWidget {
  const FactCardToShare({
    super.key,
    required this.fact,
    required this.toShowUnderFact,
    required this.toShowAboveFact,
    required this.textColor,
  });
  final String fact;
  final Widget toShowUnderFact;
  final Widget toShowAboveFact;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        image: DecorationImage(
          image: Assets.images.alternativeBg.provider(),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.all(32.sp),
      margin: EdgeInsets.symmetric(vertical: 16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          toShowAboveFact,
          SizedBox(
            height: 24.h,
          ),
          Text(
            fact,
            style: GoogleFonts.merienda(
              fontSize: 20.sp,
              color: textColor,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          toShowUnderFact,
        ],
      ),
    );
  }
}
