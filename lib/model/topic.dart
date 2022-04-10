class Topic {
  late int? id;
  late String? content;
  late bool? isActive;

  Topic({
    required this.id,
    required this.content,
    required this.isActive,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json["id"],
      content: json["content"] ?? "",
      isActive: json["isActive"] ?? false,
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
