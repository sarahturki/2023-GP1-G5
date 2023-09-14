class ContractionsModel {
  final String intervalContractions;
  final String durationContraction;

  ContractionsModel({
    required this.durationContraction,
    required this.intervalContractions,
  });

  // Convert ContractionsModel to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'intervalContractions': intervalContractions,
      'durationContraction': durationContraction,
      'timestamp':DateTime.now(),
    };
  }

  // Create a ContractionsModel from a JSON Map
  factory ContractionsModel.fromJson(Map<String, dynamic> json) {
    return ContractionsModel(
      intervalContractions: json['intervalContractions'],
      durationContraction: json['durationContraction'],
    );
  }
}
