part of 'user_data_cubit.dart';

abstract class UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataReady extends UserDataState {
  final Profile profile;
  final List<CategoryModel> categories;
  final List<double> bio;
  final CategoryModel dayCategory;

  UserDataReady({
    @required this.dayCategory,
    @required this.profile,
    @required this.categories,
    @required this.bio,
  });
}

class UserDataInit extends UserDataState {}

class UserDataError extends UserDataState {
  final Exception exception;

  UserDataError({@required this.exception});
}
