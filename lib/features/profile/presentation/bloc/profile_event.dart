// features/profile/presentation/bloc/profile_event.dart
part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  User model;

  UpdateProfileEvent({required this.model});
}
