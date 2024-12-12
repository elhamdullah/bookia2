// features/auth/presentation/page/login/login_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/end_page_spacer.dart';
import 'package:bookia/core/custom_widget/social_login.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/icons.dart';
import 'package:bookia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia/features/auth/data/request/login/user_model_params.dart';
import 'package:bookia/features/auth/presentation/page/login/forget_password.dart';
import 'package:bookia/features/auth/presentation/page/register/register_Screen.dart';
import 'package:bookia/features/nav_bar/presentation/page/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var emmailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          showLoadingDialog(context);
        } else if (state is LoginSuccessState) {
          pushAndRemoveUntil(context, const NavBarWidget());
        } else if (state is AuthErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.message);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Text(
                  'Welcome back! Glad \nto see you, Again!',
                  style: gettitleTextStyle30(),
                ),
                const Gap(40),
                ////////////////////////////////////////////////////////email
                TextfieldflormWidget(
                  controller: emmailController,
                  isobsecure: false,
                  hinttext: 'Enter your email',
                  fontsize: 15,
                  onChanged: (value) {},
                ),
                const Gap(15),

                ////////////////////////////////////////////////////////password
                TextfieldflormWidget(
                  onChanged: (value) {},
                  controller: passwordController,
                  isobsecure: true,
                  hinttext: 'Enter your password',
                  fontsize: 15,
                  suffixIconHeight: 50,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(
                      AppIcons.eyeSvg,
                    ),
                  ),
                ),

                ///////////////////////////////////////////////////////forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        pushTo(context, ForgetPassword());
                      },
                      child: Text(
                        'Forget Password?',
                        style:
                            gettitleTextStyle14(color: AppColor.darkGrayColor),
                      ),
                    ),
                  ],
                ),

                ////////////////////////////////////////////////////////login button
                const Gap(20),
                CustomButton(
                  text: "Login",
                  textcolor: Colors.white,
                  fontsize: 15,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(LoginEvent(UserModelParams(
                            email: emmailController.text,
                            password: passwordController.text,
                          )));
                      // print("hello");
                    }
                  },
                ),

                //////////////////////////////////////////////////////////divider
                Gap(34),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: AppColor.lightGrayColor,
                    )),
                    Text(
                      "     Or Login with    ",
                      style: gettitleTextStyle14(),
                    ),
                    const Expanded(
                        child: Divider(
                      color: AppColor.lightGrayColor,
                    )),
                  ],
                ),

                ////////////////////////////////////////////////////////social login
                const Gap(40),
                Row(
                  children: [
                    SocialLogin(
                      image: AppIcons.facebookSvg,
                    ),
                    const Gap(8),
                    SocialLogin(
                      image: AppIcons.googleSvg,
                    ),
                    const Gap(8),
                    SocialLogin(
                      image: AppIcons.appleSvg,
                    ),
                  ],
                ),

                /////////////////////////////////////////////////////dont have account
                const Spacer(),
                EndPageTitle(
                  text: "Don’t have an account?",
                  btntext: "Register Now",
                  pushPage: RegisterScreen(),
                ),
                const Gap(26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
