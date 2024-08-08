import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:ecotyper/shared/widgets/password_textfield.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const SecurityPage(),
      );

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  var isProcessing = false;
  var oldPassword = "";
  var newPassword = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Check for change password status
    var appBloc = context.read<AppBloc>();
    var accountBloc = context.watch<AccountBloc>();
    var state = accountBloc.state;
    var isProcessing = false;

    switch (state.updatePasswordStatus) {
      case UpdatePasswordStatus.updated:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser("Password updated successfully!");
            accountBloc.resetUpdatePasswordStatus();
          },
        );
        break;
      case UpdatePasswordStatus.processing:
        isProcessing = true;
        break;
      case UpdatePasswordStatus.error:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc
                .notifyUser("Unexpected error occur while updating password!");
            accountBloc.resetUpdatePasswordStatus();
          },
        );
        break;
      case UpdatePasswordStatus.oldPasswordNotMatch:
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            appBloc.notifyUser("The old password does not match!");
            accountBloc.resetUpdatePasswordStatus();
          },
        );
        break;
      default:
        break;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            fit: BoxFit.fill,
            opacity: 0.2,
          ),
        ),
        child: Form(
          key: _formKey,
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
                          "Update Password",
                          style: TextStyle(fontSize: 24.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              //
              SizedBox(
                height: 16.h,
              ),
              //
              // Old Password Textfield
              PasswordTextField(
                hint: "Old Password",
                onChange: (value) {
                  oldPassword = value;
                },
                validator: ValidationBuilder().required().minLength(8).build(),
              ),
              SizedBox(
                height: 16.h,
              ),
              //
              // New Password Textfield
              PasswordTextField(
                hint: "New Password",
                onChange: (value) {
                  newPassword = value;
                },
                validator: ValidationBuilder().required().minLength(8).build(),
              ),
              SizedBox(
                height: 16.h,
              ),
              //
              // Confirm Password Textfield
              PasswordTextField(
                hint: "Confirm New Password",
                validator: ValidationBuilder().required().add((value) {
                  return value != newPassword
                      ? "New Password does not match confirm password"
                      : null;
                }).build(),
              ),
              //
              // Show processing circle
              if (isProcessing)
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
                text: "Update Password",
                onTap: isProcessing
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AccountBloc>().updatePassword(
                              oldPassword: oldPassword,
                              newPassword: newPassword);
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
