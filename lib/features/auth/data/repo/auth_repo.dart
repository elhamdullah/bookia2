// features/auth/data/repo/auth_repo.dart
//methods of project

import 'package:bookia/core/services/endpoints.dart';
import 'package:bookia/features/auth/data/request/user_model_params.dart';
import 'package:bookia/features/auth/data/response/user_model_response/user_model_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  //////////////////////////////register method
  static Future<UserModelResponse?> register(UserModelParams params) async {
    try {
      var response = await Dio().post(
          AppEndPoints.baseUrl + AppEndPoints.register,
          data: params.toJson());

      if (response.statusCode == 201) {
        return UserModelResponse.fromJson(response.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  //////////////login method
  static Future<UserModelResponse?> login(UserModelParams params) async {
    try {
      var response = await Dio().post(AppEndPoints.baseUrl + AppEndPoints.login,
          data: params.toJson());

      if (response.statusCode == 200) {
        return UserModelResponse.fromJson(response.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
