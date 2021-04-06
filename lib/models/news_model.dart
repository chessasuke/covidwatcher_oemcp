class NewsModel {
  NewsModel({
    this.title,
    this.description,
    this.url,
    this.pubDate,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        title: json['title'] as String,
        url: json['url'] as String ?? '',
        pubDate: json['pubDate'] as String ?? '',
        description: json['description'] as String ?? '');
  }

  final String title;
  final String pubDate;
  final String url;
  final String description;

  printNewsItem() =>
      print('Title: $title\nDescription: $description\ndate: $pubDate');
}
