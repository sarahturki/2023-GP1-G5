
class WeeklyInfo {
  final String forMother,
      forBaby,
      title,
      forMoreInfo,
      forWeight,
      forHeight,
      week,
      id,
      image;

  WeeklyInfo({
    required this.forBaby,
    required this.forHeight,
    required this.forMoreInfo,
    required this.forMother,
    required this.forWeight,
    required this.title,
    required this.week,
    required this.id,
    required this.image,

  });
  factory WeeklyInfo.fromJson(Map<String, dynamic> json) {
    return WeeklyInfo(
      forBaby: json['forBaby'] ?? '',
      forHeight: json['forHeight'] ?? '',
      forMoreInfo: json['forMoreInfo'] ?? '',
      forMother: json['forMother'],
      forWeight: json['forWeight'],
      title: json['title'],
      week: json['week'],
      id: json['id'],
      image : json['image']

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forBaby': forBaby,
      'forHeight': forHeight,
      'forMoreInfo': forMoreInfo,
      "forMother": forMother,
      "forWeight": forWeight,
      "title": title,
      "week": week,
      "id": id,
      "image" :image
    };
  }
}
