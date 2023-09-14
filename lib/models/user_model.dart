class UserModel {
  UserModel({
    this.age,
    this.dueDate,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  DateTime? age, dueDate;
  final String firstName, lastName;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      firstName: json["name"],
      email: json["email"],
      lastName: json["last_name"],
      age: json["age"].toDate(),
      dueDate: json["dueDate"].toDate());
  UserModel copyWith({
    DateTime? age,
    DateTime? dueDate,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return UserModel(
      age: age ?? this.age,
      dueDate: dueDate ?? this.dueDate,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": firstName,
      "last_name": lastName,
      "email": email,
      "age": age,
      "dueDate": dueDate,
    };
    return data;
  }
}
