import 'package:vot_senat_client/handlers/shared_pref_handler.dart';

class RoleHandler {
  RoleHandler._internal();

  static RoleHandler instance = RoleHandler._internal();

  bool check(List<String> roles) {
    return roles.contains(SharedPrefHandler.instance.role);
  }
}
