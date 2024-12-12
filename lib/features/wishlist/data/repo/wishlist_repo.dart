// features/wishlist/data/repo/wishlist_repo.dart

import 'dart:developer';

import 'package:bookia/core/services/endpoints.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/core/services/remote/dio_provider.dart';
import 'package:bookia/features/wishlist/data/models/response/get_whish_list_response/get_whish_list_response.dart';

class WishlistRepo {
  static String token = "6050|wlbIRX1XvNeYh2X3wk3bBQ5vw21iTW8GzBfkWvQT";
  static Future<GetWhishListResponse> getWhishList() async {
    try {
      var response = await DioProvider.get(
          endPoint: AppEndPoints.getWhistList,
          headers: {"Authorization": 'Bearer $token'});
      print("---------------------");

      if (response.statusCode == 200) {
        return GetWhishListResponse.fromJson(response.data);
      } else {
        return GetWhishListResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  //add
  static Future<bool> addToWhishlist({required int productId}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.addToWhistList,
        headers: {"Authorization": 'Bearer $token'},
        data: {
          'product_id': productId,
        },
      );
      print(response.data);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());

      return false;
    }
  }

  //remove
  static Future<bool> removeFromWhishlist({required int productId}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.removeFromWhistList,
        headers: {"Authorization": 'Bearer $token'},
        data: {
          'product_id': productId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());

      return false;
    }
  }
}
