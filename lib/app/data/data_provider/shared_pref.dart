import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  static final instance = SharedPref._();

  Future<void> setValue({String key, int value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, value);
  }

  Future<int> getValue({String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
}
