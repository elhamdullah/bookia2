// core/services/remote/dio_provider.dart
import 'package:bookia/core/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioProvider {
  static late Dio _dio;

  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoints.baseUrl,
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  static Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(
      endPoint,
      data: data,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );
  }

  static Future<Response> post({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.post(
      endPoint,
      queryParameters: data,
      options: Options(headers: headers),
      data: data,
    );
  }

  static Future<Response> put(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await _dio.put(
      endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> delete(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await _dio.delete(
      endPoint,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
