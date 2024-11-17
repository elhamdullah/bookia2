// core/custom_widget/custom_button.dart
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.bgcolor,
      this.textcolor,
      this.fontsize,
      this.width,
      this.height,
      required this.text,
      this.borderWidth,
      required this.onPressed});

  Color? bgcolor;
  Color? textcolor;
  double? fontsize;
  double? width;
  double? height;
  String text;
  double? borderWidth;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? mediaquery.width,
          height ?? 60,
        ),
        backgroundColor: bgcolor ?? AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColor.darkColor, width: borderWidth ?? 0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: gettitlegeneral(
          fontsize: fontsize,
          color: textcolor,
        ),
      ),
    );
  }
}
