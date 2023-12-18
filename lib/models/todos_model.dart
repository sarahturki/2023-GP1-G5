class Todo {
  bool completed;
  String name;
  String uid;
  DateTime? dateTime;

  Todo({
    required this.completed,
    required this.name,
    required this.uid,
    this.dateTime,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      completed: json['completed'] ?? false,
      name: json['name'] ?? '',
      uid: json['uid'] ?? '',
      dateTime:
          json["dateTime"] == null ? DateTime.now() : json["dateTime"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completed': completed,
      'name': name,
      'uid': uid,
      'dateTime': DateTime.now(),
    };
  }
}
