import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/data/data_provider/sqlite_helper.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'profiles_state.dart';

class ProfilesCubit extends Cubit<ProfilesState> {
  ProfilesCubit() : super(ProfilesLoading()) {
    getProfiles();
  }

  Future<void> getProfiles() async {
    try {
      var profiles = await DBProvider.instance.getAllProfiles();
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
      await DBProvider.instance.insertProfile(profile);
      var profiles = await DBProvider.instance.getAllProfiles();
      emit(ProfilesUpdate(profiles));
    } catch (e) {
      emitProfilesException(e);
    }
  }

  void emitInitProfile(Profile profile) async {
    try {
      await DBProvider.instance.insertProfile(profile);
      var profiles = await DBProvider.instance.getAllProfiles();
      emit(ProfilesInit(profiles.first));
    } catch (e) {
      emitProfilesException(e);
    }
  }
}
