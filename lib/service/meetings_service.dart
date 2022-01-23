import 'dart:convert';

import 'package:http/http.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/utils/api.dart';

class MeetingsService {
  const MeetingsService._internal();

  static const MeetingsService instance = MeetingsService._internal();

  Future<Response> getAll() async {
    Uri url = Uri.parse("${Api.server}/meetings");

    try {
      Response response = await get(url);
      return response;
    } on Exception {
      rethrow;
    }
  }

  Future<Response> create(Meeting meeting) async {
    //TODO add user to request whne auth is implemented
    Uri url = Uri.parse("${Api.server}/meetings/1");

    try {
      Response response = await post(
        url,
        body: meeting.toJson(),
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
}
