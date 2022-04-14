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
      yes: json["votes"][VoteValues.yes],
      no: json["votes"][VoteValues.no],
      abtain: json["votes"][VoteValues.abtain],
      usersWhoVoted: json["usersWhoVoted"] != null ? jsonDecode(json["usersWhoVoted"]) as List<int> : [],
    );
  }

  Map toJson() {
    return {
      "id": id ?? "",
      "content": content ?? "",
      "isActive": isActive ?? false,
    };
  }
}
