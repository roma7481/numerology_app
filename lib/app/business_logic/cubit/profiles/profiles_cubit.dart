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

  void emitAddProfile(Profile profile) async {
    try {
      await ProfileDBProvider.instance.insertProfile(profile);
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesUpdate(profiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  void emitUpdateProfile(Profile profile) async {
    try {
      emit(ProfilesUpdate([profile]));
      await ProfileDBProvider.instance.updateProfile(profile);
    } catch (e) {
      emitProfilesException(e);
    }
  }

  void emitInitProfile(Profile profile) async {
    try {
      await ProfileDBProvider.instance.insertProfile(profile);
      var profiles = await ProfileDBProvider.instance.getAllProfiles();
      emit(ProfilesInit(profiles.first));
    } catch (e) {
      emitProfilesException(e);
    }
  }
}
