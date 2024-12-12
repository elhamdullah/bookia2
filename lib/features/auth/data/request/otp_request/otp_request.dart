// features/auth/data/request/otp_request/otp_request.dart
class OtpRequest {
  int? verifyCode;

  OtpRequest({this.verifyCode});

  factory OtpRequest.fromJson(Map<String, dynamic> json) => OtpRequest(
        verifyCode: json['verify_code'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'verify_code': verifyCode,
      };
}
