import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/data/models/OtherApp.dart';
import 'package:numerology/app/data/repository/OtherAppsRepository.dart';

class OtherAppCubit extends Cubit<OtherAppsState> {

  OtherAppCubit() : super(const OtherAppsLoading());

  void loadOtherApps(BuildContext context) {
    emit(const OtherAppsLoading());

    OtherAppsRepository().getAll().then((value) {
      emit(OtherAppsLoaded(value));
    }).catchError((error) {
      emit(const OtherAppsError());
    });
  }
}
abstract class OtherAppsState {
  const OtherAppsState();
}

class OtherAppsLoading extends OtherAppsState {

  const OtherAppsLoading();
}

class OtherAppsError extends OtherAppsState {
  const OtherAppsError();
}

class OtherAppsLoaded extends OtherAppsState {

  final List<OtherApp> otherApps;

  const OtherAppsLoaded(this.otherApps);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OtherAppsLoaded && o.otherApps == otherApps;
  }
}