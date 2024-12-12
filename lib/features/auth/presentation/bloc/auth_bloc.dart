// features/auth/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:bookia/core/services/local_storage.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/data/request/login/user_model_params.dart';
import 'package:bookia/features/auth/data/request/new_password/new_password.dart';
import 'package:bookia/features/auth/data/request/otp_request/otp_request.dart';
import 'package:bookia/features/auth/data/request/send_code/send_code.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<SendCodeEvent>(SendCode);
    on<OtpCodeEvent>(OtpCode);
    on<NewPasswordEvent>(newPassword);
  }

//////////register
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    try {
      await AuthRepo.register(event.params).then((value) {
        if (value != null) {
          AppLocalStorage.cacheData(AppLocalStorage.token, value.data?.token);

          emit(RegisterSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  /////////login
  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    try {
      await AuthRepo.login(event.params).then((value) {
        if (value != null) {
          AppLocalStorage.cacheData(AppLocalStorage.token, value.data?.token);
          emit(LoginSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  SendCode(SendCodeEvent event, Emitter<AuthState> emit) async {
    emit(SendCodeLoadingState());
    try {
      await AuthRepo.sendCode(event.params!).then((value) {
        if (value != null) {
          emit(SendCodeSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  OtpCode(OtpCodeEvent event, Emitter<AuthState> emit) async {
    emit(OtpCodeLoadingState());
    try {
      await AuthRepo.OtpCode(event.params!).then((value) {
        if (value) {
          emit(OtpCodeSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  /////////new password
  newPassword(NewPasswordEvent event, Emitter<AuthState> emit) async {
    emit(NewPasswordLoadingState());
    try {
      await AuthRepo.newPassword(event.params!).then((value) {
        if (value != null) {
          emit(NewPasswordSuccessState());
        }
      });
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
