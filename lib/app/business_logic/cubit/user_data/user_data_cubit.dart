import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/data/data_provider/shared_pref.dart';
import 'package:numerology/app/data/data_provider/sqlite_helper.dart';
import 'package:numerology/app/data/models/category_model.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataLoading()) {
    _updateUserData();
  }

  Future _updateUserData() async {
    try {
      var primaryProfileId =
          await SharedPref.instance.getValue(key: primaryUserKey);
      if (primaryProfileId == null) {
        emit(UserDataReady(profile: null, categories: [], dayNumber: null));
      } else {
        var profile = await DBProvider.instance.getProfile(primaryProfileId);
        emitPrimaryUserUpdate(profile);
      }
    } catch (e) {
      emitPrimaryUserError(e);
    }
  }

  Future<void> emitPrimaryUserUpdate(Profile profile) async {
    try {
      await SharedPref.instance
          .setValue(key: primaryUserKey, value: profile.profileId);
      var dataParser = Globals.instance.getDataParser();

      emit(UserDataReady(
          profile: profile,
          categories: dataParser.getCategories(),
          dayNumber: null));
    } catch (e) {
      emitPrimaryUserError(e);
    }
  }

  emitPrimaryUserError(Exception e) {
    emit(UserDataError(exception: e));
  }
}
