import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/ui/pages/security_page.dart';
import 'package:ecotyper/features/account/ui/pages/terms_page.dart';
import 'package:ecotyper/features/account/ui/pages/update_account_page.dart';
import 'package:ecotyper/features/account/ui/widgets/account_item.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/features/account/ui/widgets/profile_details_section.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      );

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            fit: BoxFit.fill,
            opacity: 0.6,
          ),
        ),
        width: screenSize.width,
        padding: EdgeInsets.only(top: 24.h),
        child: ListView(
          children: const [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CloseButton(),
                ),
                AvatarWidget(
                  size: 170,
                ),
                ProfileDetailsSection(),
              ],
            ),
            AccountOptions(),
          ],
        ),
      ),
    );
  }
}

class AccountOptions extends StatelessWidget {
  const AccountOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 32.sp,
      ),
      margin: EdgeInsets.only(top: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.sp),
          topRight: Radius.circular(32.sp),
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        children: [
          // AccountItem(
          //   title: "Scores",
          //   icon: Icons.token_rounded,
          //   onTap: () => Navigator.push(
          //     context,
          //     ScoresPage.route(),
          //   ),
          // ),
          AccountItem(
            title: "Update Account",
            icon: Icons.person,
            onTap: () => Navigator.push(
              context,
              UpdateAccountPage.route(),
            ),
          ),
          AccountItem(
            title: "Security",
            icon: Icons.lock,
            onTap: () {
              Navigator.push(context, SecurityPage.route());
            },
          ),
          AccountItem(
            title: "Terms",
            icon: Icons.token_rounded,
            onTap: () => Navigator.push(
              context,
              TermsPage.route(),
            ),
          ),
          AccountItem(
            title: "Log out",
            icon: Icons.logout_rounded,
            onTap: () => context.read<AccountBloc>().logout(),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
              ),
              child: const Text("Delete Account"),
            ),
          ),
        ],
      ),
    );
  }
}
