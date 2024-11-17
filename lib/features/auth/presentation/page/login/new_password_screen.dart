// features/auth/presentation/page/login/new_password_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/custom_widget/textfieldflorm_widget.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/auth/presentation/page/login/password_success_changed.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
            ),
            Gap(15),
            TextfieldflormWidget(
              isobsecure: true,
              hinttext: "Confirm Password",
            ),

            ////////////////////////////////////////////////////////////////button
            Gap(40),
            CustomButton(
              text: "Reset Password",
              onPressed: () {
                pushWithReplacement(context, PasswordSuccessChanged());
              },
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
