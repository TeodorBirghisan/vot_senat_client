import 'dart:convert';

import 'package:vot_senat_client/service/vote_service.dart';

class Topic {
  late int? id;
  late String? content;
  late bool? isActive;
  int? yes;
  int? no;
  int? abtain;
  List<int>? usersWhoVoted;

  Topic({
    required this.id,
    required this.content,
    required this.isActive,
    this.yes,
    this.no,
    this.abtain,
    this.usersWhoVoted,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json["topicId"],
      content: json["content"] ?? "",
      isActive: json["isActive"] ?? false,
      yes: _hasVotes(json, VoteValues.yes) ? json["votes"][VoteValues.yes] : 0,
      no: _hasVotes(json, VoteValues.no) ? json["votes"][VoteValues.no] : 0,
      abtain: _hasVotes(json, VoteValues.abtain) ? json["votes"][VoteValues.abtain] : 0,
      usersWhoVoted: json["usersWhoVotes"] != null ? json["usersWhoVotes"].cast<int>() : [],
    );
  }

  static bool _hasVotes(Map<String, dynamic> json, String voteValue) {
    if (json["votes"] == null || json["votes"][voteValue] == null) {
      return false;
    }

    return true;
  }

  Map toJson() {
    return {
      "id": id ?? "",
      "content": content ?? "",
    };
  }
}
