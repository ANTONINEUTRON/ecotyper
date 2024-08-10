import 'package:ecotyper/features/account/ui/widgets/signin_with_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/ui/pages/account_page.dart';
import 'package:ecotyper/features/account/ui/pages/signin_page.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:ecotyper/shared/widgets/custom_textfield.dart';
import 'package:ecotyper/shared/widgets/password_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    super.key,
    this.closeOnComplete = false,
  });

  static route({bool closeOnComplete = false}) => MaterialPageRoute(
        builder: (context) => SignupPage(
          closeOnComplete: closeOnComplete,
        ),
      );

  final bool closeOnComplete;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var confirmPassword = "";
  var name = "";

  @override
  Widget build(BuildContext context) {
    var isProcessing = false;
    // var errorMessage = "";

    var accountBloc = context.watch<AccountBloc>();
    var state = accountBloc.state;
    var appBloc = context.read<AppBloc>();

    switch (state.accountStatus) {
      case AccountStatus.signedIn:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
            context,
            AccountPage.route(),
          );
          appBloc.notifyUser(
              "Account created successfully check your mail for verification link");
        });
        break;
      case AccountStatus.processing:
        isProcessing = true;
        break;
      case AccountStatus.signInError:
        appBloc.notifyUser(
            "An error occurred when registering your account, check your network connection and try again");
        accountBloc.resetAccountStatus();

        break;
      case AccountStatus.authHandlerException:
        appBloc.notifyUser(state.authHandlerException!.message);
        accountBloc.resetAccountStatus();
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CloseButton(),
                    Text(
                      "Register",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, SigninPage.route());
                      },
                      child: const Text("Sign In"),
                    ),
                  ],
                ),
              ),
              //
              // Name Textfield
              CustomTextfield(
                validator: ValidationBuilder().required().build(),
                hint: "Name",
                onChange: (value) => name = value,
              ),
              SizedBox(
                height: 16.h,
              ),
              //
              // Email Textfield
              CustomTextfield(
                validator: ValidationBuilder().email().required().build(),
                hint: "Email",
                onChange: (value) => email = value,
                // helper:
                //     "Please ensure you provide a valid email address that is active",
              ),
              SizedBox(
                height: 16.h,
              ),
              //
              // Password Textfield
              PasswordTextField(
                onChange: (value) {
                  password = value;
                },
                validator: ValidationBuilder().minLength(8).required().build(),
              ),
              SizedBox(
                height: 16.h,
              ),
              //
              // Confirm Password Textfield
              PasswordTextField(
                hint: "Confirm Password",
                onChange: (value) {
                  confirmPassword = value;
                },
                validator: ValidationBuilder().required().add((value) {
                  return value != password
                      ? "Password does not equals confirm password"
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
                text: "Register",
                onTap: isProcessing
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AccountBloc>().createUserAccount(
                              name: name, email: email, password: password);
                        }
                      },
              ),
              SizedBox(
                height: 32.h,
              ),
              const Row(
                children: [
                  Flexible(
                    child: Divider(),
                  ),
                  Text("Or sign in with"),
                  Flexible(
                    child: Divider(),
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              const SigninWithGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
