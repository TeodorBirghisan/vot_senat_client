import 'dart:convert';

import 'package:http/http.dart';
import 'package:vot_senat_client/handlers/headers_handler.dart';
import 'package:vot_senat_client/model/meeting.dart';
import 'package:vot_senat_client/model/topic.dart';
import 'package:vot_senat_client/utils/api.dart';

class TopicService {
  const TopicService._internal();

  static const TopicService instance = TopicService._internal();

  Future<Response> getAll(Meeting meeting) async {
    Uri url = Uri.parse("${Api.server}/topics/${meeting.id}");

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

  Future<Response> create(Topic topic, Meeting meeting) async {
    //TODO add user to request whne auth is implemented
    Uri url = Uri.parse("${Api.server}/topics/${meeting.id}");

    try {
      Response response = await post(
        url,
        body: topic.toJson(),
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }

  List<Topic> deserializeAll(Response response) {
    String body = response.body;
    return (json.decode(body) as List).map((data) => Topic.fromJson(data)).toList();
  }

  Topic deserializeOne(Response response) {
    String body = response.body;
    return Topic.fromJson(json.decode(body));
  }
}
