// features/auth/presentation/page/register/register_Screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/end_page_spacer.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/features/auth/bloc/auth_bloc.dart';
import 'package:bookia/features/auth/data/request/user_model_params.dart';
import 'package:bookia/features/home/home_screen.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showLoadingDialog(context);
        } else if (state is RegisterSuccessState) {
          pushAndRemoveUntil(context, const HomeScreen());
        } else if (state is AuthErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello! Register to get\n started',
                    style: gettitleTextStyle30(),
                  ),
                  Gap(40),
                  ////////////////////////////////////////////////////////username
                  TextfieldflormWidget(
                    controller: nameController,
                    isobsecure: false,
                    hinttext: "Username",
                    fontsize: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  /////////////////////////////////////////////////////////email
                  Gap(12),
                  TextfieldflormWidget(
                    controller: emailController,
                    isobsecure: false,
                    hinttext: "Email",
                    fontsize: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  ///////////////////////////////////////////////////////password
                  Gap(12),
                  TextfieldflormWidget(
                    isobsecure: true,
                    controller: passwordController,
                    hinttext: "Password",
                    fontsize: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  ///////////////////////////////////////////////////////confirm password
                  Gap(12),
                  TextfieldflormWidget(
                    controller: confirmpasswordController,
                    isobsecure: true,
                    hinttext: "Confirm password",
                    fontsize: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),

                  ///////////////////////////////////////////////////register button
                  Gap(30),
                  CustomButton(
                    text: "Register",
                    textcolor: Colors.white,
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        context.read<AuthBloc>().add(RegisterEvent(
                            UserModelParams(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                passwordConfirmation:
                                    confirmpasswordController.text)));
                      }
                    },
                  ),

                  /////////////////////////////////////////////////////already have account
                  Spacer(),

                  EndPageTitle(
                    text: "Already have an account?",
                    btntext: "Login Now",
                    pushPage: LogInScreen(),
                  ),
                  Gap(26),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
