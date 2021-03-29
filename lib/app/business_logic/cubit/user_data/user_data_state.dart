part of 'user_data_cubit.dart';

abstract class UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataReady extends UserDataState {
  final Profile profile;
  final List<CategoryModel> categories;
  final CategoryModel dayCategory;

  UserDataReady({
    @required this.dayCategory,
    @required this.profile,
    @required this.categories,
  });
}

class UserDataError extends UserDataState {
  final Error exception;

  UserDataError({@required this.exception});
}
