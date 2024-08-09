

import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateAvatarWidget extends StatelessWidget {
  const UpdateAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appBloc = context.read<AppBloc>();
    var accountBloc = context.watch<AccountBloc>();
    var state = accountBloc.state;
    var isProcessing = false;

    switch (state.uploadPPStatus) {
      case UploadPPStatus.uploaded:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser("Updated Profile Pics successfully!");
            accountBloc.resetUpdateProfilePicsStatus();
          },
        );
        break;
      case UploadPPStatus.processing:
        isProcessing = true;
        break;
      case UploadPPStatus.error:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser(
                "An unexpected error occured when updating profile pics");
            accountBloc.resetUpdateProfilePicsStatus();
          },
        );
        break;
      case UploadPPStatus.fileNotSelected:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser("No image was selected");
            accountBloc.resetUpdateProfilePicsStatus();
          },
        );
        break;
      default:
        break;
    }

    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: AvatarWidget(
            size: 170,
          ),
        ),
        Positioned(
          left: 80,
          right: 0,
          bottom: 16.h,
          child: isProcessing
              ? const CircularProgressIndicator()
              : CustomIconButton(
                  onPressed: () {
                    accountBloc.uploadProfilePics();
                  },
                  icon: const Icon(Icons.edit),
                ),
        )
      ],
    );
  }
}
