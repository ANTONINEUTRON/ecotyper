import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/select_difficulty_dropdown.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/select_section_body.dart';
import 'package:ecotyper/features/home/ui/pages/home_page.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/close_page_icon_button.dart';

class SelectSectionPage extends StatefulWidget {
  const SelectSectionPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) {
          return const SelectSectionPage();
        },
      );

  @override
  State<SelectSectionPage> createState() => _SelectSectionPageState();
}

class _SelectSectionPageState extends State<SelectSectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            fit: BoxFit.fill,
            opacity: 0.7,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                margin: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClosePageIconButton(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          HomePage.route(),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const SelectDifficultyDropdown(),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  child: const SelectSectionBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
