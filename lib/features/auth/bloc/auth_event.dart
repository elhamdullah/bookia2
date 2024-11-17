// features/auth/bloc/auth_event.dart
part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final UserModelParams params;

  LoginEvent(this.params);
}

class RegisterEvent extends AuthEvent {
  final UserModelParams params;

  RegisterEvent(this.params);
}
