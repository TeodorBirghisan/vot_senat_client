import 'dart:io';

import 'package:vot_senat_client/handlers/shared_pref_handler.dart';

class HeadersHandler {
  static Map<String, String>? createAuthToken() => {
        HttpHeaders.authorizationHeader: "Bearer ${SharedPrefHandler.instance.token ?? ""}",
      };
}
