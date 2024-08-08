import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/bloc/account_state.dart';
import 'package:ecotyper/features/account/ui/pages/signup_page.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/gen/assets.gen.dart';
import 'package:ecotyper/shared/widgets/custom_rect_button.dart';
import 'package:ecotyper/shared/widgets/custom_textfield.dart';
import 'package:ecotyper/shared/widgets/password_textfield.dart';
import 'package:form_validator/form_validator.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({
    super.key,
    this.closeOnComplete = false,
  });

  static route({bool closeOnComplete = false}) => MaterialPageRoute(
        builder: (context) => SigninPage(
          closeOnComplete: closeOnComplete,
        ),
      );

  final bool closeOnComplete;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    var isProcessing = false;
    var errorMessage = "";

    var appBloc = context.read<AppBloc>();
    var accountBloc = context.watch<AccountBloc>();
    var state = accountBloc.state;

    switch (state.accountStatus) {
      case AccountStatus.processing:
        isProcessing = true;
        break;
      case AccountStatus.signInError:
        errorMessage =
            "An error occurred when log in to your account, check your network connection and try again";

        appBloc.notifyUser(errorMessage);

        accountBloc.resetAccountStatus();
        break;
      case AccountStatus.authHandlerException:
        errorMessage = state.authHandlerException!.message;

        appBloc.notifyUser(errorMessage);
        accountBloc.resetAccountStatus();
        break;
      case AccountStatus.signedIn:
        Navigator.pop(context);
        break;
      default:
        break;
    }

    return Scaffold(
      // appBar: AppBar(
      //   leading: const CloseButton(),
      //   title: const Text("Sign In"),
      //   actions: [

      //   ],
      // ),
      body: SafeArea(
        child: Container(
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
                // const Text("Sign in to your account"),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CloseButton(),
                      Text(
                        "Sign In",
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            SignupPage.route(),
                          );
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
                CustomTextfield(
                  validator: ValidationBuilder().email().build(),
                  hint: "Email",
                  onChange: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                PasswordTextField(
                  onChange: (value) => password = value,
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
                  height: 8.h,
                ),
                if (!isProcessing)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password?",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 16.h,
                ),
                CustomRectButton(
                  text: "Login",
                  onTap: isProcessing
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<AccountBloc>()
                                .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
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
                CustomRectButton(
                  text: "Google",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
