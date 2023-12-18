class ContractionsModel {
  final String intervalContractions;
  final String durationContraction;
  final DateTime timestamp;
  ContractionsModel({
    required this.durationContraction,
    required this.intervalContractions,
    required this.timestamp,
  });

  // Convert ContractionsModel to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'intervalContractions': intervalContractions,
      'durationContraction': durationContraction,
      'timestamp': timestamp
    };
  }

  // Create a ContractionsModel from a JSON Map
  factory ContractionsModel.fromJson(Map<String, dynamic> json) {
    return ContractionsModel(
      intervalContractions: json['intervalContractions'],
      timestamp: json["timestamp"].toDate(),
      durationContraction: json['durationContraction'],
    );
  }
}
