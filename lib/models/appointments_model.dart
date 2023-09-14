
class AppointmentsModel {
  final String title, desription, id;
  final DateTime dateTime;

  AppointmentsModel({
    required this.title,
    required this.desription,
    required this.dateTime,
    required this.id,
  });
  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
        title: json['title'],
        desription: json['desription'],
        id: json['id'],
        dateTime: json['dateTime'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desription': desription,
      'id': id,
      "dateTime": dateTime,
    };
  }
}
