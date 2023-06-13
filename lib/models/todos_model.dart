class Todo {
  bool completed;
  String name;
  String uid;

  Todo({
    required this.completed,
    required this.name,
    required this.uid,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      completed: json['completed'] ?? false,
      name: json['name'] ?? '',
      uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completed': completed,
      'name': name,
      'uid': uid,
    };
  }
}
