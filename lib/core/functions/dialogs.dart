// core/functions/dialogs.dart

import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showErrorDialog(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: gettitleTextStyle16(color: AppColor.whiteColor),
      )));
}

showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "loading",
              style: gettitleTextStyle30(),
            ),
          ],
        );
      });
}
