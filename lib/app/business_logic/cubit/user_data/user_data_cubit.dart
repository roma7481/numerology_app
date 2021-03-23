import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> with HydratedMixin {
  UserDataCubit() : super(UserDataState(primaryProfileId: null));

  emitPrimaryUserUpdate(int primaryUserId) {
    emit(UserDataState(primaryProfileId: primaryUserId));
  }

  @override
  UserDataState fromJson(Map<String, dynamic> json) {
    UserDataState _state = UserDataState.fromMap(json);
    return _state;
  }

  @override
  Map<String, dynamic> toJson(UserDataState state) {
    return state.toMap();
  }
}
