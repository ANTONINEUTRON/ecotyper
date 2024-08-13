import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextSection extends StatelessWidget {
  const TextSection({
    super.key, required this.title, required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 8.h,
                left: 16.w,
              ),
              child: Column(
                children: [
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
