class SendCode {
  String? email;

  SendCode({this.email});

  factory SendCode.fromJson(Map<String, dynamic> json) => SendCode(
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
