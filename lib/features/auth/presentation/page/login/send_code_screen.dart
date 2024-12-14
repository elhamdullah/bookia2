// features/auth/presentation/page/login/send_code_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/end_page_spacer.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia/features/auth/data/request/otp_request/otp_request.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/login/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/functions/pinput.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({super.key});

  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
  //form key
  final formkey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is OtpCodeLoadingState) {
          showLoadingDialog(context);
        } else if (state is OtpCodeSuccessState) {
          pushAndRemoveUntil(
            context,
            NewPasswordScreen(
              verifyCode: int.parse(controller.text),
            ),
          );
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
                  "OTP Verification",
                  style: gettitleTextStyle30(),
                ),
                Gap(10),
                Text(
                  "Enter the verification code we just sent on your email address.",
                  style: gettitleTextStyle18(color: AppColor.grayColor),
                ),

                /////////////////////////////////////////////////////OTP verification form
                Gap(30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                          defaultPinTheme: defaultPinTheme,
                          controller: controller,
                          length: 6,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter OTP';
                            }
                            return null;
                          },
                          //pin width
                          followingPinTheme: PinTheme(
                            width: 53,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )),
                    ],
                  ),
                ),

                ////////////////////////////////////////////////////////verify button
                Gap(40),
                CustomButton(
                  text: "Verify",
                  fontsize: 25,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            OtpCodeEvent(OtpRequest(
                              verifyCode: int.parse(controller.text),
                            )),
                          );
                      print("hello");
                    }
                  },
                  textcolor: Colors.white,
                ),

                /////////////////////////////////////////////////////Didn’t received code? Resend
                Spacer(),
                EndPageTitle(
                  text: "Didn’t received code?",
                  btntext: "Resend",
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
