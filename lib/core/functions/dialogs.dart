// core/functions/dialogs.dart

import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';

enum DialogType { success, error, loading }

showErrorDialog(BuildContext context, String message,
    {DialogType type = DialogType.error}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: type == DialogType.error
          ? Colors.red
          : type == DialogType.success
              ? AppColor.primaryColor
              : Colors.green,
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
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColor.primaryColor,
              strokeWidth: 7,
              backgroundColor: AppColor.darkColor,
              strokeAlign: 2,
            )
          ],
        );
      });
}
