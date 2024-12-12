// features/auth/presentation/page/login/forget_password.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/end_page_spacer.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia/features/auth/data/request/login/user_model_params.dart';
import 'package:bookia/features/auth/data/request/send_code/send_code.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/login/send_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SendCodeLoadingState) {
          showLoadingDialog(context);
        } else if (state is SendCodeSuccessState) {
          pushTo(context, const SendCodeScreen());
        } else if (state is AuthErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /////////////////////////////////////////////////////////////title
                Text(
                  "Forgot Password?",
                  style: gettitleTextStyle30(),
                ),
                Gap(10),
                Text(
                  "Don't worry! It occurs. Please enter the email address linked with your account.",
                  style: gettitleTextStyle18(color: AppColor.grayColor),
                ),

                ////////////////////////////////////////////////////////////email
                Gap(30),
                TextfieldflormWidget(
                  controller: emailController,
                  isobsecure: false,
                  hinttext: "Enter your email",
                ),

                ///////////////////////////////////////////////////////////send code button
                Gap(40),
                CustomButton(
                  text: "Send Code",
                  textcolor: Colors.white,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            SendCodeEvent(
                              SendCode(
                                email: emailController.text,
                              ),
                            ),
                          );
                      print("hello");
                    }
                  },
                ),

                /////////////////////////////////////////////////////remember password
                Spacer(),
                EndPageTitle(
                  text: "Remember Password?",
                  btntext: "Login",
                  pushPage: LogInScreen(),
                ),
                Gap(26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
