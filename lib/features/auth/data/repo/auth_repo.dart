// features/auth/data/repo/auth_repo.dart
//methods of project

import 'package:bookia/core/services/endpoints.dart';
import 'package:bookia/core/services/remote/dio_provider.dart';
import 'package:bookia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bookia/features/auth/data/request/login/user_model_params.dart';
import 'package:bookia/features/auth/data/request/new_password/new_password.dart';
import 'package:bookia/features/auth/data/request/otp_request/otp_request.dart';
import 'package:bookia/features/auth/data/request/send_code/send_code.dart';
import 'package:bookia/features/auth/data/response/new_password_response/new_password_response.dart';
import 'package:bookia/features/auth/data/response/user_model_response/user_model_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  //////////////////////////////register method
  static Future<UserModelResponse?> register(UserModelParams params) async {
    try {
      var response = await DioProvider.post(
          endPoint: AppEndPoints.register, data: params.toJson());
      if (response.statusCode == 201) {
        return UserModelResponse.fromJson(response.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  //////////////login method
  static Future<UserModelResponse?> login(UserModelParams params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.login,
        data: params.toJson(),
      );
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        return UserModelResponse.fromJson(response.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

//////////////forget password
  static Future<SendCode?> sendCode(SendCode params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.forgetPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return SendCode.fromJson(response.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  ////////////////send otp code
  static Future<bool> OtpCode(OtpRequest params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.verifyCode,
        data: params.toJson(),
      );

      debugPrint(response.data.toString());

      if (response.statusCode == 200) {
        return true;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  //////////////new password method
  static Future<NewPasswordResponse?> newPassword(NewPassword params) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.newPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return NewPasswordResponse.fromJson(response.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
