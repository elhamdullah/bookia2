// features/profile/presentation/bloc/profile_bloc.dart
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookia/features/auth/data/response/new_password_response/user.dart';
import 'package:bookia/features/profile/data/model/get_profile_response.dart';
import 'package:bookia/features/profile/data/model/repo/profile_repo.dart';
import 'package:meta/meta.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(getProfile);
    on<UpdateProfileEvent>(updateProfile);
  }

  GetProfileResponse? profileResponse;
  // get profile
  getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(GetProfileLoadingState());

    try {
      await ProfileRepo.getProfileData().then((value) {
        if (value != null) {
          profileResponse = value;
          emit(GetProfileSuccessState());
        } else {
          emit(GetProfileErrorState('Something went wrong'));
        }
      });
    } on Exception catch (e) {
      log(e.toString());
      emit(GetProfileErrorState('Something went wrong'));
    }
  }

  updateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoadingState());

    try {
      await ProfileRepo.updateProfile(event.model).then((value) {
        if (value) {
          emit(UpdateProfileSuccessState());
        } else {
          emit(UpdateProfileErrorState('Something went wrong'));
        }
      });
    } on Exception catch (e) {
      log(e.toString());
      emit(UpdateProfileErrorState('Something went wrong'));
    }
  }
}
