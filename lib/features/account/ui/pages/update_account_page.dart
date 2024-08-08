import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_icon_button.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:ecotyper/shared/widgets/custom_textfield.dart';

class UpdateAccountPage extends StatefulWidget {
  const UpdateAccountPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const UpdateAccountPage(),
      );

  @override
  State<UpdateAccountPage> createState() => _UpdateAccountPageState();
}

class _UpdateAccountPageState extends State<UpdateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var name = "";
  // bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    // bool isVerified = false;
    // bool isVerificationProcessing = false;
    bool isUploadProcessing = false;
    var screenSize = MediaQuery.of(context).size;

    var appBloc = context.read<AppBloc>();
    var accountBloc = context.watch<AccountBloc>();
    var accountState = accountBloc.state;

    name = accountState.user!.name;
    email = accountState.user!.email;

    switch (accountState.updateAccountStatus) {
      case UpdateAccountStatus.updated:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            Navigator.pop(context);
            appBloc.notifyUser("Updated successfully!");
            accountBloc.resetUpdateAccountStatus();
          },
        );
        break;
      case UpdateAccountStatus.processing:
        isUploadProcessing = true;
        break;
      case UpdateAccountStatus.error:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser(
                "An error occured when updating your account details.\nPlease try again");
            accountBloc.resetUpdateAccountStatus();
          },
        );
        break;
      default:
        break;
    }

    // switch (accountState.verificationStatus) {
    //   case VerificationStatus.verified:
    //     isVerified = true;
    //     break;
    //   case VerificationStatus.processing:
    //     isVerificationProcessing = true;
    //     break;
    //   case VerificationStatus.error:
    //     appBloc.notifyUser(
    //         "An unexpected error occured when verifying your email address\n Please try again");
    //     break;
    //   default:
    //     break;
    // }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            fit: BoxFit.fill,
            opacity: 0.2,
          ),
        ),
        width: screenSize.width,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: CloseButton(),
              ),
              SizedBox(
                height: 200.h,
                child: const UpdateAvatarWidget(),
              ),
              CustomTextfield(
                validator: ValidationBuilder().email().required().build(),
                isEnabled: false,
                hint: "Email",
                initialValue: accountState.user?.email,
                onChange: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextfield(
                validator: ValidationBuilder().required().minLength(6).build(),
                hint: "Name",
                initialValue: accountState.user?.name,
                onChange: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              //
              // Show verify button
              // ElevatedButton.icon(
              //   onPressed: () {
              //     //If the current email address in text box is valid
              //     //Send verification link
              //     var validate = ValidationBuilder().email().build();
              //     // check if valid email was entered in the textfield
              //     if (validate(email) == null) {
              //       accountBloc.verifyUserEmail(email);
              //     } else {
              //       appBloc.notifyUser("The email entered is not valid");
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.green.shade800,
              //     foregroundColor: Colors.white,
              //     // shape: RoundedRectangleBorder(
              //     //   borderRadius: BorderRadius.circular(8.sp),
              //     // ),
              //   ),
              //   label: Text("Verify Email Address"),
              //   icon: Icon(Icons.verified),
              //   iconAlignment: IconAlignment.end,
              // ),
              // SizedBox(
              //   height: 16.h,
              // ),

              //
              // Show processing circle
              if (isUploadProcessing)
                Column(
                  children: [
                    SizedBox(height: 16.h),
                    const CircularProgressIndicator(),
                  ],
                ),
              SizedBox(
                height: 32.h,
              ),
              CustomRectButton(
                text: "Update Profile",
                onTap: isUploadProcessing
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AccountBloc>().updateUserDeatils(
                                email: email,
                                name: name,
                              );
                        }
                      },
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            accountBloc.resetUpdatePPStatus();
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
            accountBloc.resetUpdatePPStatus();
          },
        );
        break;
      case UploadPPStatus.fileNotSelected:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser("No image was selected");
            accountBloc.resetUpdatePPStatus();
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
