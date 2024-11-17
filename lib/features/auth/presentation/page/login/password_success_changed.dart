// features/auth/presentation/page/login/password_success_changed.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class PasswordSuccessChanged extends StatelessWidget {
  const PasswordSuccessChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.SuccessSvg),

              /////////////////////////////////////////////////////////////title
              Gap(40),
              Text(
                "Password Changed!",
                style: gettitleTextStyle26(),
              ),
              Gap(10),
              Text(
                "Your password has been changed successfully.",
                style: gettitleTextStyle15(color: AppColor.grayColor),
              ),
              ///////////////////////////////////////////////////////////back to login page
              Gap(40),
              CustomButton(
                text: "Back to Login",
                textcolor: Colors.white,
                onPressed: () {
                  pushWithReplacement(context, LogInScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
