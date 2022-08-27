import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKeys {
  static const String token = 'TOKEN';
  static const String role = 'ROLE';
  static const String userId = 'USER_ID';
}

class SharedPrefHandler {
  SharedPrefHandler._internal();

  static SharedPrefHandler instance = SharedPrefHandler._internal();

  SharedPreferences? _prefs;

  Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  set token(String? token) {
    if (token != null) {
      _prefs!.setString(SharedPrefsKeys.token, token);
      return;
    }

    throw 'Token should not be null';
  }

  void removeToken() {
    _prefs!.remove(SharedPrefsKeys.token);
  }

  String? get token {
    return _prefs!.getString(SharedPrefsKeys.token);
  }

  set role(String? role) {
    if (role != null) {
      _prefs!.setString(SharedPrefsKeys.role, role);
      return;
    }

    throw 'Token should not be null';
  }

  void removeRole() {
    _prefs!.remove(SharedPrefsKeys.role);
  }

  String? get role {
    return _prefs!.getString(SharedPrefsKeys.role);
  }

  set userId(int? userId) {
    if (userId != null) {
      _prefs!.setInt(SharedPrefsKeys.userId, userId);
      return;
    }

    throw 'Token should not be null';
  }

  void removeUserId() {
    _prefs!.remove(SharedPrefsKeys.userId);
  }

  int? get userId {
    return _prefs!.getInt(SharedPrefsKeys.userId);
  }
}
