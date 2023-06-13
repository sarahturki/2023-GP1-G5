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
}
