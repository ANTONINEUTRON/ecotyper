import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/shared/constants.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = context.read<AccountBloc>();

    return accountBloc.state.accountStatus != AccountStatus.signedIn
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: const AvatarWidget(
                  size: 120,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(20, 30),
                      topRight: Radius.elliptical(20, 50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          accountBloc.state.user!.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 50,
                            crossAxisSpacing: 8,
                          ),
                          children: [
                            ScoreDetailsItem(
                              title: "Overall",
                              score:
                                  "${accountBloc.getUserTotalScore()} ${AppConstants.token}",
                            ),
                            ScoreDetailsItem(
                              title: "Best",
                              score:
                                  "${accountBloc.getUserBestScore()} ${AppConstants.token}",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

class ScoreDetailsItem extends StatelessWidget {
  const ScoreDetailsItem({
    super.key,
    required this.title,
    required this.score,
  });
  final String title;
  final String score;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      padding: EdgeInsets.only(top: 4.h),
      child: Column(
        children: [
          Text(title),
          Text(score),
        ],
      ),
    );
  }
}
