class Topic {
  late int? id;
  late String? content;

  Topic({
    required this.id,
    required this.content,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json["id"],
      content: json["content"] ?? "",
    );
  }

  Map toJson() {
    return {
      "id": id ?? "",
      "content": content ?? "",
    };
  }
}
