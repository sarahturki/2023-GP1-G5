class ReportModel {
  final String bloodsuger,
      bloodpressure,
      id,
      weight,
      vitaminD,
      calcium,
      hemoglobin;

  final DateTime dateTime;

  ReportModel({
    required this.bloodsuger,
    required this.bloodpressure,
    required this.id,
    required this.weight,
    required this.vitaminD,
    required this.dateTime,
    required this.calcium,
    required this.hemoglobin,
  });
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      bloodsuger: json['bloodsuger'],
      bloodpressure: json['bloodpressure'],
      id: json['id'],
      calcium: json['calcium'],
      dateTime: json["datetime"].toDate(),
      hemoglobin: json["hemoglobin"],
      vitaminD: json["vitaminD"],
      weight: json["weight"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bloodsuger': bloodsuger,
      'bloodpressure': bloodpressure,
      'id': id,
      "datetime": dateTime,
      'calcium': calcium,
      'hemoglobin': hemoglobin,
      'vitaminD': vitaminD,
      'weight': weight,
    };
  }

  ReportModel copyWith({
    String? bloodsuger,
    String? bloodpressure,
    String? id,
    String? weight,
    String? vitaminD,
    DateTime? dateTime,
    String? calcium,
    String? hemoglobin,
  }) {
    return ReportModel(
      bloodsuger: bloodsuger ?? this.bloodsuger,
      bloodpressure: bloodpressure ?? this.bloodpressure,
      id: id ?? this.id,
      weight: weight ?? this.weight,
      vitaminD: vitaminD ?? this.vitaminD,
      dateTime: dateTime ?? this.dateTime,
      calcium: calcium ?? this.calcium,
      hemoglobin: hemoglobin ?? this.hemoglobin,
    );
  }
}
