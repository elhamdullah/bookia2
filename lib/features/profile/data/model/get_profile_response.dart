// features/profile/data/model/get_profile_response.dart
import 'package:bookia/features/auth/data/response/new_password_response/user.dart';

class GetProfileResponse {
  User? data;
  String? message;
  List<dynamic>? error;
  int? status;

  GetProfileResponse({this.data, this.message, this.error, this.status});

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      data: json['data'] == null
          ? null
          : User.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'error': error,
        'status': status,
      };
}
