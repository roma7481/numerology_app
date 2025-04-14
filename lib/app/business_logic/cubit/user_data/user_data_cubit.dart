import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/data/data_provider/profile_helper.dart';
import 'package:numerology/app/data/data_provider/shared_pref.dart';
import 'package:numerology/app/data/models/category_model.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataLoading()) {
    _updateUserData();
  }

  Future<void> _updateUserData() async {
    try {
      final primaryProfileId = await SharedPref.instance.getValue(key: primaryUserKey);
      if (primaryProfileId == null) {
        emit(UserDataInit());
        return;
      }

      final profile = await ProfileDBProvider.instance.getProfile(primaryProfileId);
      if (profile == null) {
        emitPrimaryUserError(Exception('Profile not found'));
        return;
      }

      emitPrimaryUserUpdate(profile);
    } catch (e) {
      emitPrimaryUserError(e);
    }
  }


  Future<void> emitPrimaryUserUpdate(Profile profile) async {
    try {
      await SharedPref.instance
          .setValue(key: primaryUserKey, value: profile.profileId!);
      var dataParser = Globals.instance.getDataParser();
      var categories = await dataParser.getCategories(profile);

      emit(
        UserDataReady(
            profile: profile,
            categories: categories,
            dayCategory: await dataParser.getPersonalDay(profile),
            bio: dataParser.getPersonalBio(profile)),
      );
    } catch (e) {
      emitPrimaryUserError(e);
    }
  }

  Future<void> emitCalcCategoriesUpdate() async {
    try {
      var primaryProfileId =
          await SharedPref.instance.getValue(key: primaryUserKey);
      if (primaryProfileId != null) {
        Profile? profile = await ProfileDBProvider.instance.getProfile(primaryProfileId);

        if (profile != null) {
          emitPrimaryUserUpdate(profile);
        } else {
          throw Exception("No profile found for ID: $primaryProfileId");
        }
      }
    } catch (e) {
      emitPrimaryUserError(e);
    }
  }

  emitPrimaryUserError(Object e) {
    emit(UserDataError(exception: e));
  }
}
