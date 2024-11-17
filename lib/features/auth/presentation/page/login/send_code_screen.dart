// features/auth/presentation/page/login/send_code_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/end_page_spacer.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/login/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/functions/pinput.dart';

class SendCodeScreen extends StatelessWidget {
  const SendCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                ),
              ],
            ),

            ////////////////////////////////////////////////////////verify button
            Gap(40),
            CustomButton(
              text: "Verify",
              onPressed: () {
                pushWithReplacement(context, NewPasswordScreen());
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
    );
  }
}
