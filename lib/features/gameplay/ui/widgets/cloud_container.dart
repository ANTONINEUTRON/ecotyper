import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/text_widget.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class CloudContainer extends StatelessWidget {
  const CloudContainer({
    super.key,
    required this.cloudImage,
    required this.text,
    this.onCompleteText,
  });

  final AssetGenImage cloudImage;
  final String text;
  final Function()? onCompleteText;

  @override
  Widget build(BuildContext context) {
    double multiplier = text.length + 1;
    return Container(
      height: 15 * multiplier,
      width: 17 * multiplier,
      margin: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: cloudImage.provider(),
          fit: BoxFit.fill,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            top: 32.h,
            right: 4.w,
          ),
          child: TextWidget(
            text: text.toUpperCase(),
            onCompleteText: onCompleteText,
          ),
        ),
      ),
    );
  }
}
