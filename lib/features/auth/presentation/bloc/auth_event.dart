// features/auth/bloc/auth_event.dart
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//login event
class LoginEvent extends AuthEvent {
  final UserModelParams params;

  LoginEvent(this.params);
}

//register event
class RegisterEvent extends AuthEvent {
  final UserModelParams params;

  RegisterEvent(this.params);
}

//send code event
class SendCodeEvent extends AuthEvent {
  final SendCode? params;

  SendCodeEvent(this.params);
}

//send OTPcode event
class OtpCodeEvent extends AuthEvent {
  final OtpRequest? params;

  OtpCodeEvent(this.params);
}

//send new password event
class NewPasswordEvent extends AuthEvent {
  final NewPassword? params;

  NewPasswordEvent(this.params);
}
