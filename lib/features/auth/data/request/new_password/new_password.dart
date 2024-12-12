// features/auth/data/request/new_password/new_password.dart
class NewPassword {
  int? verifyCode;
  String? newPassword;
  String? newPasswordConfirmation;

  NewPassword({
    this.verifyCode,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory NewPassword.fromJson(Map<String, dynamic> json) => NewPassword(
        verifyCode: json['verify_code'] as int?,
        newPassword: json['new_password'] as String?,
        newPasswordConfirmation: json['new_password_confirmation'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'verify_code': verifyCode,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      };
}
