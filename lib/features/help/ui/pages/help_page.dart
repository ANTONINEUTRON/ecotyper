import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:ecotyper/features/help/data/repository/help_items.dart';
import 'package:ecotyper/features/help/ui/widgets/text_section.dart';
import 'package:ecotyper/shared/widgets/close_page_icon_button.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const PreviewPage(),
      );

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final listOfHelpItems = HelpItems.list;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: listOfHelpItems.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            opacity: 0.3,
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.only(
          top: 36.sp,
          left: 8.w,
          right: 8.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClosePageIconButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "HELP",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                )
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:4.h),
              child: ButtonsTabBar(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                controller: controller,
                tabs: listOfHelpItems
                    .map(
                      (item) => Tab(
                        child: Text(item.title),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: listOfHelpItems.map(
                  (helpItem) {
                    return ListView(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: helpItem.image.image(
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        TextSection(
                          title: helpItem.title,
                          child: Text(helpItem.description),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: CustomRectButton(
                  onTap: () {
                    var currentIndex = controller.index;
                    if (currentIndex == listOfHelpItems.length - 1) {
                      controller.animateTo(0);
                    } else {
                      controller.animateTo(currentIndex + 1);
                    }
                  },
                  text: "Next",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomGradient extends StatelessWidget {
  const BottomGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.sp),
          bottomRight: Radius.circular(16.sp),
        ),
        gradient: LinearGradient(
          end: FractionalOffset.bottomCenter,
          begin: FractionalOffset.topCenter,
          colors: [
            Colors.transparent,
            Color(0XFF414141),
            Color(0XFF000000),
          ],
          stops: [0.0, 0.51, 0.74],
        ),
      ),
      height: 200.h,
    );
  }
}
