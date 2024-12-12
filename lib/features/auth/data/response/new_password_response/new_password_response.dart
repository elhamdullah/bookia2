import 'data.dart';

class NewPasswordResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  NewPasswordResponse({this.data, this.message, this.error, this.status});

  factory NewPasswordResponse.fromJson(Map<String, dynamic> json) {
    return NewPasswordResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
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
