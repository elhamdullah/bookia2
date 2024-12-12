// features/auth/presentation/page/login/new_password_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia/features/auth/data/request/new_password/new_password.dart';
import 'package:bookia/features/auth/data/response/new_password_response/new_password_response.dart';
import 'package:bookia/features/auth/presentation/page/login/password_success_changed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({super.key, required this.verifyCode});
  int verifyCode;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  //form key
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is NewPasswordLoadingState) {
          showLoadingDialog(context);
        } else if (state is NewPasswordSuccessState) {
          pushAndRemoveUntil(context, const PasswordSuccessChanged());
        } else if (state is AuthErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /////////////////////////////////////////////////////////////title
                Text(
                  "Create new password",
                  style: gettitleTextStyle30(),
                ),
                Gap(10),
                Text(
                  "Your new password must be unique from those previously used.",
                  style: gettitleTextStyle18(color: AppColor.grayColor),
                ),
                ///////////////////////////////////////////////////////new password textform
                Gap(32),
                TextfieldflormWidget(
                  isobsecure: true,
                  hinttext: "New Password",
                  controller: passwordController,
                ),
                Gap(15),
                TextfieldflormWidget(
                  isobsecure: true,
                  hinttext: "Confirm Password",
                  controller: confirmpasswordController,
                ),

                ////////////////////////////////////////////////////////////////button
                Gap(40),
                CustomButton(
                  text: "Reset Password",
                  onPressed: () {
                    // pushWithReplacement(context, PasswordSuccessChanged());
                    if (formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            NewPasswordEvent(NewPassword(
                              verifyCode: widget.verifyCode,
                              newPassword: passwordController.text,
                              newPasswordConfirmation:
                                  confirmpasswordController.text,
                            )),
                          );
                      print("hello");
                    }
                  },
                  textcolor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
