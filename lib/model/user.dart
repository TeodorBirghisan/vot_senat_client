class User {
  int id;
  String email;
  String firstName;
  String lastName;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 999999,
      email: json["email"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
    );
  }

  Map toJson() {
    return {
      "id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
