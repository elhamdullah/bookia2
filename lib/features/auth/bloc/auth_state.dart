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


/////error
class AuthErrorState extends AuthState {
  String message;
  AuthErrorState(this.message);
}
