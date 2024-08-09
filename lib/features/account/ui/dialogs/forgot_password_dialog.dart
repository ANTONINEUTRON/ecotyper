import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:ecotyper/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final formKey = GlobalKey<FormState>();
  var _emailAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AccountBloc>().resetResetPasswordStatus();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    String errorMessage = "";
    String sentMessage = "";

    var acctBloc = context.watch<AccountBloc>();
    var state = acctBloc.state;

    switch (state.resetPasswordStatus) {
      case ResetPasswordStatus.processing:
        print("Processing");
        isLoading = true;
        break;
      case ResetPasswordStatus.error:
        print("Error");
        errorMessage =
            "An error occured! \nEnsure a stable network connection and the email address you entered is correct";
        break;
      case ResetPasswordStatus.sent:
        print("Sent");
        sentMessage = "A password reset link has been sent to $_emailAddress";
        break;
      default:
        break;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Text(
            "Enter your email address to recover your password",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
          if (sentMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                sentMessage,
                style: const TextStyle(color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          SizedBox(
            height: 32.h,
          ),
          Form(
            key: formKey,
            child: isLoading
                ? Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Sending Reset Link")
                    ],
                  )
                : Column(
                    children: [
                      CustomTextfield(
                        validator: ValidationBuilder().email().build(),
                        hint: "Email Address",
                        onChange: (value) {
                          _emailAddress = value;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomRectButton(
                        text: "Get Reset Link",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            acctBloc.sendUserPasswordResetMail(_emailAddress);
                            isLoading = true;
                            // setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
