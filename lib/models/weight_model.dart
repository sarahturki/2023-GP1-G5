class WeightModel {
  final String id;
  String weight;
  WeightModel({required this.id, required this.weight});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
    };
  }

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
      id: json['id'] as String,
      weight: json['weight'] as String,
    );
  }
}
