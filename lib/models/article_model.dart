class ArticleModel {
  late String author;
  late String title;
  late String desc;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;

  ArticleModel(
      {required this.author,
      required this.title,
      required this.desc,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});
}
