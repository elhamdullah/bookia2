// features/welcome/welcome_screen.dart
import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/auth/presentation/page/login/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/register/register_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            AppImages.welcome,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),

                  ////////////////////////////////////////////////////////bookia logo
                  SvgPicture.asset(AppImages.logoSvg),
                  const Gap(9),
                  Text(
                    "Order Your Book Now!",
                    style: gettitleTextStyle18(),
                  ),

                  const Spacer(
                    flex: 5,
                  ),

                  //////////////////////////////////////////////////////////button
                  CustomButton(
                    text: 'Login',
                    fontsize: 15,
                    textcolor: AppColor.whiteColor,
                    onPressed: () {
                      pushTo(context, LogInScreen());
                    },
                  ),
                  const Gap(15),
                  CustomButton(
                    text: "Register",
                    fontsize: 15,
                    bgcolor: AppColor.whiteColor,
                    textcolor: Colors.black,
                    borderWidth: 1,
                    onPressed: () {
                      pushTo(context, RegisterScreen());
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
