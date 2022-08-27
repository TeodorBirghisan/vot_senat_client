import 'package:http/http.dart';
import 'package:vot_senat_client/handlers/headers_handler.dart';
import 'package:vot_senat_client/utils/api.dart';

class VoteValues {
  static const String yes = "YES";
  static const String abtain = "ABTAIN";
  static const String no = "NO";
}

class VoteService {
  VoteService._internal();

  static final VoteService instance = VoteService._internal();

  Future<Response> vote(int topicId, String voteValue) async {
    Uri url = Uri.parse("${Api.server}/vote/$topicId");

    try {
      Response response = await post(
        url,
        body: {"voteValue": voteValue},
        headers: HeadersHandler.createAuthToken(),
      );
      return response;
    } on Exception {
      rethrow;
    }
  }
}
