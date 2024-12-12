// features/profile/data/model/repo/profile_repo.dart
import 'dart:developer';
import 'package:bookia/core/services/endpoints.dart';
import 'package:bookia/core/services/remote/dio_provider.dart';
import 'package:bookia/features/auth/data/response/new_password_response/user.dart';
import 'package:bookia/features/profile/data/model/get_profile_response.dart';
import 'package:dio/dio.dart';

class ProfileRepo {
  static String token = "6050|wlbIRX1XvNeYh2X3wk3bBQ5vw21iTW8GzBfkWvQT";
  static Future<GetProfileResponse?> getProfileData() async {
    try {
      var response = await DioProvider.get(
          endPoint: AppEndPoints.getProfile,
          headers: {"Authorization": 'Bearer $token'});
      if (response.statusCode == 200) {
        var model = GetProfileResponse.fromJson(response.data);
        return model;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

// cart
  static Future<bool> updateProfile(User model) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.updateProfile,
        data: {
          'name': model.name,
          if (model.image != null)
            'image': await MultipartFile.fromFile(model.image!,
                filename: model.image?.split('/').last),
          'phone': model.phone,
          'address': model.address
        },
        headers: {"Authorization": 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

   static Future<GetProfileResponse?> getOrderHistoryData() async {
    try {
      var response = await DioProvider.get(
          endPoint: AppEndPoints.orderHistory,
          headers: {"Authorization": 'Bearer $token'});
      if (response.statusCode == 200) {
        var model = GetProfileResponse.fromJson(response.data);
        return model;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
