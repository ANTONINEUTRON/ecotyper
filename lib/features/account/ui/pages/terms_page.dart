import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const TermsPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            fit: BoxFit.fill,
            opacity: 0.2,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.sp),
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CloseButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Terms and Condition",
                        style: TextStyle(fontSize: 24.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
