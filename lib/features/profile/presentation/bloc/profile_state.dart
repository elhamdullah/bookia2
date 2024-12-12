// features/profile/presentation/bloc/profile_state.dart
part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


// get profile

final class GetProfileLoadingState extends ProfileState {}

final class GetProfileSuccessState extends ProfileState {}

final class GetProfileErrorState extends ProfileState {
  final String error;

  GetProfileErrorState(this.error);
}

final class UpdateProfileLoadingState extends ProfileState {}

final class UpdateProfileSuccessState extends ProfileState{}

final class UpdateProfileErrorState extends ProfileState {
  final String error;

  UpdateProfileErrorState(this.error);
}
