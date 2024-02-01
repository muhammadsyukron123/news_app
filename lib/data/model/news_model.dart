class NewsModel {
  final String id;
  final String title;
  final String imageUrl;
  final String link;

  NewsModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.link,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      link: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'urlToImage': imageUrl,
      'url': link,
    };
  }
}
