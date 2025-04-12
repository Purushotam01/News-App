class Article {
  final String title;
  final String description;
  final String content;
  final String url;
  final String image;
  final String publishedAt;
  final String source;

  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '', // GNews uses "image"
      publishedAt: json['publishedAt'] ?? '',
      source: json['source'] != null && json['source']['name'] != null
          ? json['source']['name']
          : '',
    );
  }
}
