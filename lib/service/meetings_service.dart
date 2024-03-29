import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:vot_senat_client/handlers/headers_handler.dart';
import 'package:vot_senat_client/handlers/shared_pref_handler.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/utils/api.dart';

class MeetingsService {
  const MeetingsService._internal();

  static const MeetingsService instance = MeetingsService._internal();

  Future<Response> getAllHistory() async {
    Uri url = Uri.parse("${Api.server}/meetings/finished");

    try {
      Response response = await get(
        url,
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getAll() async {
    Uri url = Uri.parse("${Api.server}/meetings");

    try {
      Response response = await get(
        url,
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> create(Meeting meeting) async {
    Uri url = Uri.parse("${Api.server}/meetings");

    try {
      Response response = await post(
        url,
        body: meeting.toJson(),
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> deleteOne(int meetingId) async {
    Uri url = Uri.parse("${Api.server}/meetings/$meetingId");

    try {
      Response response = await delete(
        url,
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> joinMeeting(int meetingId) async {
    Uri url = Uri.parse("${Api.server}/participation/joinMeeting/$meetingId");

    try {
      Response response = await post(
        url,
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> exitMeeting(int meetingId) async {
    Uri url = Uri.parse("${Api.server}/participation/exitMeeting/$meetingId");

    try {
      Response response = await put(
        url,
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getParticipants(int meetingId) async {
    Uri url = Uri.parse("${Api.server}/participation/allUsers/$meetingId");

    try {
      Response response = await get(
        url,
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  List<Meeting> deserializeAll(Response response) {
    String body = response.body;
    return (json.decode(body) as List).map((data) => Meeting.fromJson(data)).toList();
  }

  Meeting deserializeOne(Response response) {
    String body = response.body;
    return Meeting.fromJson(json.decode(body));
  }

  int deserializeId(Response response) {
    String body = response.body;
    return json.decode(body);
  }
}
