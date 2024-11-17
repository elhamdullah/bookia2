// core/custom_widget/social_login.dart
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLogin extends StatelessWidget {
   SocialLogin({super.key,required this.image});
  String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColor.lightGrayColor)),
        child: SvgPicture.asset(
          image,
        ),
        height: 56,
        width: 65,
      ),
    );
  }
}
