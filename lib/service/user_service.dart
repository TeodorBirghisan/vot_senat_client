import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vot_senat_client/utils/api.dart';

class UserService {
  UserService._internal();

  static final UserService instance = UserService._internal();

  Future<Response> login(String email, String password) async {
    Uri url = Uri.parse("${Api.server}/auth-jwt/login");

    try {
      Response response = await post(
        url,
        body: {
          "email": email,
          "password": password,
        },
      );
      return response;
    } on Exception {
      rethrow;
    }
  }
}
