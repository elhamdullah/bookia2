// features/auth/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/data/request/user_model_params.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
  }

//////////register
  register(RegisterEvent event, Emitter<AuthState> emit) {
    emit(RegisterLoadingState());
    try {
      AuthRepo.register(event.params).then((value) {
        if (value != null) {
          emit(RegisterSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  /////////login
  login(LoginEvent event, Emitter<AuthState> emit) {
    emit(LoginLoadingState());
    try {
      AuthRepo.login(event.params).then((value) {
        if (value != null) {
          emit(LoginSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
