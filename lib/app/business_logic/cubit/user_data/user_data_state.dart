part of 'user_data_cubit.dart';

abstract class UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataReady extends UserDataState {
  final Profile profile;
  final List<CategoryModel> categories;

  UserDataReady({@required this.profile, @required this.categories});
}

class UserDataError extends UserDataState {
  final Exception exception;

  UserDataError({@required this.exception});
}
