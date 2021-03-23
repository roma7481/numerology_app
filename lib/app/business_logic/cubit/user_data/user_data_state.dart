part of 'user_data_cubit.dart';

class UserDataState {
  int primaryProfileId;

  UserDataState({this.primaryProfileId});

  factory UserDataState.fromMap(Map<String, dynamic> map) {
    return new UserDataState(
      primaryProfileId: map['primaryProfileId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'primaryProfileId': this.primaryProfileId,
    } as Map<String, dynamic>;
  }
}
