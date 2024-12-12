// features/auth/bloc/auth_state.dart
part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

////login
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

//////register
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

//////send code
class SendCodeLoadingState extends AuthState {}

class SendCodeSuccessState extends AuthState {}

//////OTP code
class OtpCodeLoadingState extends AuthState {}

class OtpCodeSuccessState extends AuthState {}

//////New Password
class NewPasswordLoadingState extends AuthState {}

class NewPasswordSuccessState extends AuthState {}

/////error
class AuthErrorState extends AuthState {
  String message;
  AuthErrorState(this.message);
}
