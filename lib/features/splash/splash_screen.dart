// features/splash/splash_screen.dart
import 'package:bookia/core/functions/newNavigation.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/core/utils/images.dart';
import 'package:bookia/features/nav_bar/presentation/page/nav_bar_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String? token = AppLocalStorage.getCachedData(key: AppLocalStorage.token);
    Future.delayed(Duration(seconds: 5), () {
      if (token == null) {
        return pushWithReplacement(context, WelcomeScreen());
      }
      return pushWithReplacement(context, NavBarWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.logoSvg,
              fit: BoxFit.cover,
            ),
            Gap(9),
            Text(
              "Order Your Book Now!",
              style: gettitleTextStyle18(),
            )
          ],
        ),
      ),
    );
  }
}
