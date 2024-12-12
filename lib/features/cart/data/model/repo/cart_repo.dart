// features/cart/data/repo/cart_repo.dart

import 'dart:developer';
import 'package:bookia/core/services/endpoints.dart';
import 'package:bookia/core/services/remote/dio_provider.dart';
import 'package:bookia/features/cart/data/model/get_cart_response/get_cart_response.dart';
import 'package:bookia/features/wishlist/data/models/response/get_whish_list_response/get_whish_list_response.dart';

class CartRepo {
  static String token = "6050|wlbIRX1XvNeYh2X3wk3bBQ5vw21iTW8GzBfkWvQT";
  static Future<GetCartResponse?> getCartList() async {
    try {
      var response = await DioProvider.get(
          endPoint: AppEndPoints.getCartList,
          headers: {"Authorization": 'Bearer $token'});
      print("---------------------");

      if (response.statusCode == 200) {
        return GetCartResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  //add
  static Future<bool> addToCartlist({required int productId}) async {
    try {
      var response = await DioProvider.post(
        headers: {"Authorization": 'Bearer $token'},
        data: {
          'product_id': productId,
        },
        
        endPoint: AppEndPoints.addToCartList,
      );
      //print(response.data);

      if (response.statusCode == 201) {
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
  static Future<bool> removeFromCartlist({required int productId}) async {
    try {
      var response = await DioProvider.post(
        endPoint: AppEndPoints.removeFromCartList,
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
