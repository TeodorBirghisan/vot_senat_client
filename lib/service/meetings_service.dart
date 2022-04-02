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
    Response response = Response(
        json.encode([
          Meeting(id: 0, description: "description", title: "title", startDate: DateTime.now(), status: "status"),
          Meeting(id: 1, description: "description", title: "title", startDate: DateTime.now(), status: "status"),
          Meeting(id: 2, description: "description", title: "title", startDate: DateTime.now(), status: "status"),
          Meeting(id: 3, description: "description", title: "Buna dimineata", startDate: DateTime.now(), status: "status"),
        ]),
        200);

    return response;
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
    //TODO add user to request whne auth is implemented
    Uri url = Uri.parse("${Api.server}/meetings/8");

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
      Response response = await delete(url);
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
