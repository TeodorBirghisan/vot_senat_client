import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String token = 'TOKEN';
}

class SharedPrefHandler {
  SharedPrefHandler._internal();

  static SharedPrefHandler instance = SharedPrefHandler._internal();

  late SharedPreferences _prefs;

  Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void set token(String? token) {
    if (token != null) {
      _prefs.setString(SharedPrefsKeys.token, token);
      return;
    }

    throw 'Token should not be null';
  }

  void removeToken() {
    _prefs.remove(SharedPrefsKeys.token);
  }

  String? get token {
    return _prefs.getString(SharedPrefsKeys.token);
  }
}
