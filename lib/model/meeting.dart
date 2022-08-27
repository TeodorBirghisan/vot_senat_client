class Meeting {
  late int? id;
  late String? description;
  late String? title;
  late DateTime? startDate;
  late String? status;

  Meeting({
    required this.id,
    required this.description,
    required this.title,
    required this.startDate,
    required this.status,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json["id"],
      description: json["description"],
      title: json["title"],
      startDate: DateTime.parse(json["startDate"] ?? DateTime.now().toIso8601String()).toLocal(),
      status: json["status"],
    );
  }

  Map toJson() {
    return {
      "id": id ?? "",
      "description": description ?? "",
      "title": title ?? "",
      "startDate": startDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      "status": status ?? "",
    };
  }
}
