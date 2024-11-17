// core/functions/pinput.dart
import 'dart:ui';

import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 70,
  height: 80,
  textStyle: const TextStyle(
      fontSize: 30, color: Colors.black, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(color: AppColor.primaryColor, width: 1),
    borderRadius: BorderRadius.circular(20),
  ),
);
