class ArticleModel {
  final String description, title, image;

  ArticleModel({
    required this.description,
    required this.title,
    required this.image,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      description: json['description'],
      title: json['title'],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'title': title,
      "image": image,
    };
  }
}
