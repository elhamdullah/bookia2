// features/home/data/repo/home_repo.dart
import 'package:bookia/core/services/endpoints.dart';
import 'package:bookia/core/services/remote/dio_provider.dart';
import 'package:bookia/features/home/data/model/response/get_arrivals_books_response/get_arrivals_books_response.dart';
import 'package:bookia/features/home/data/model/response/get_sliders_response/get_sliders_response.dart';
import 'package:bookia/features/home/data/model/response/search/search_response/search_response.dart';

class HomeRepo {
  static String token = "6050|wlbIRX1XvNeYh2X3wk3bBQ5vw21iTW8GzBfkWvQT";
  //new arrivals repo
  static Future<GetArrivalsBooksResponse?> getNewArrivalsBooks() async {
    try {
      var response =
          await DioProvider.get(endPoint: AppEndPoints.newArrivalsBooks);
      if (response.statusCode == 200) {
        return GetArrivalsBooksResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

//sliders repo
  static Future<GetSlidersResponse?> getSliders() async {
    try {
      var response = await DioProvider.get(endPoint: AppEndPoints.sliders);
      if (response.statusCode == 200) {
        return GetSlidersResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //search
  static Future<SearchResponse?> getSearchBooks(String book) async {
    try {
      var response = await DioProvider.get(
          endPoint: AppEndPoints.search, queryParameters: {
            "name": book
          });
      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //checkout repo
  static Future<bool> placeOrder({
    String? name,
    String? email,
    String? phone,
    String? governorateId,
    String? address,
  }) async {
    try {
      var response = await DioProvider.post(
        queryParameters: {
          "name": name,
          'email': email,
          'phone': phone,
          'governorate_id': governorateId,
          'address': address
        },
        headers: {"Authorization": 'Bearer $token'},
        endPoint: AppEndPoints.placeOrder,
      );
      //  print("--------------------------");
      if (response.statusCode == 200) {
        //    print("--------------------------");
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
    }
  }
}
