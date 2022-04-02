import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vot_senat_client/handlers/headers_handler.dart';
import 'package:vot_senat_client/handlers/shared_pref_handler.dart';
import 'package:vot_senat_client/utils/api.dart';

class InvitationService {
  InvitationService._internal();

  static final InvitationService instance = InvitationService._internal();

  Future<Response> invite(String email) async {
    Uri url = Uri.parse("${Api.server}/invitation");

    try {
      Response response = await post(
        url,
        body: {
          "email": email,
        },
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> signUpInvitation(String email, String password, invitationCode) async {
    Uri url = Uri.parse("${Api.server}/auth-jwt/login");

    try {
      Response response = await post(
        url,
        body: {
          "email": email,
          "password": password,
        },
        headers: {
          "invitationToken": invitationCode,
        },
      );
      return response;
    } on Exception {
      rethrow;
    }
  }
}
