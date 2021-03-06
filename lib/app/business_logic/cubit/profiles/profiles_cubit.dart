import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/data/data_provider/profile_helper.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'profiles_state.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  ProfilesCubit() : super(ProfilesLoading()) {
    emitGetProfiles();
  }

  Future<void> emitGetProfiles() async {
    try {
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesReady(profiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  void emitProfilesException(exception) => emit(ProfilesError(
        exception: exception,
      ));

  Future<void> emitAddProfile(Profile profile) async {
    try {
      await ProfileDBProvider.instance.insertProfile(profile);
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesReady(profiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  Future<Profile> emitAddPrimProfile(Profile profile) async {
    var newPrim;
    try {
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      var currentPrim =
          profiles.firstWhere((element) => element.isSelected == 1);

      currentPrim = currentPrim.copyWith(isSelected: 0);
      newPrim = profile.copyWith(isSelected: 1);

      await ProfileDBProvider.instance.updateProfile(currentPrim);
      await ProfileDBProvider.instance.insertProfile(newPrim);

      var newProfiles = await ProfileDBProvider.instance.getAllProfiles();
      newPrim = newProfiles
          .firstWhere((element) => element.profileName == profile.profileName);

      emit(ProfilesReady(newProfiles));
    } catch (e) {
      emitProfilesException(e);
    }
    return newPrim;
  }

  Future<void> emitDeleteProfile(Profile profile) async {
    try {
      await ProfileDBProvider.instance.deleteProfile(profile);
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesReady(profiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  Future<Profile> emitDeletePrimProfile(Profile profile) async {
    var newPrim;
    try {
      await ProfileDBProvider.instance.deleteProfile(profile);

      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      newPrim = profiles.first.copyWith(isSelected: 1);
      await ProfileDBProvider.instance.updateProfile(newPrim);

      var newProfiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesReady(newProfiles));
    } catch (e) {
      emitProfilesException(e);
    }
    return newPrim;
  }

  Future<void> emitSetPrimProfile(Profile profile) async {
    try {
      var newPrim = profile.copyWith(isSelected: 1);

      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      var currentPrim =
          profiles.firstWhere((element) => element.isSelected == 1);

      currentPrim = currentPrim.copyWith(isSelected: 0);

      await ProfileDBProvider.instance.updateProfile(currentPrim);
      await ProfileDBProvider.instance.updateProfile(newPrim);

      var newProfiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesReady(newProfiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  Future<void> emitUpdateProfile(Profile profile) async {
    try {
      await ProfileDBProvider.instance.updateProfile(profile);
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesReady(profiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  Future<void> emitInitProfile(Profile profile) async {
    try {
      await ProfileDBProvider.instance.insertProfile(profile);
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesInit(profiles.first));
    } catch (e) {
      emitProfilesException(e);
    }
  }
}
