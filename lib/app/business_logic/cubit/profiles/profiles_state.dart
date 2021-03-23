part of 'profiles_cubit.dart';

@immutable
abstract class ProfilesState {}

class ProfilesLoading extends ProfilesState {}

class ProfilesReady extends ProfilesState {
  final List<Profile> profiles;

  ProfilesReady(this.profiles);
}

class ProfilesUpdate extends ProfilesState {
  final List<Profile> profiles;

  ProfilesUpdate(this.profiles);
}

class ProfilesInit extends ProfilesState {
  final int profileId;

  ProfilesInit(this.profileId);
}

class ProfilesError extends ProfilesState {
  final Exception exception;

  ProfilesError({@required this.exception});
}
