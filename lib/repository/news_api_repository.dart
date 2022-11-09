import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class NewsApiRepsitory {
  var news;
  List<ArticleModel> newsList = [];
  Future<void> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=e27e79c0932a4445b853ddfea265ddde");
    news = Hive.box("news_api_box").get("news_api", defaultValue: []);
    print(news);
    if (news.isEmpty) {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        news = jsonData;
        Hive.box("news_api_box").put("news_api", jsonData);
      }
    }

    print(news);
    news["articles"].forEach((value) {
      // print("v-->>" + value["title"]);
      ArticleModel articleModel = ArticleModel(
          author: value["author"] ?? "",
          title: value["title"] ?? "",
          desc: value["description"] ?? "",
          url: value["url"] ?? "",
          urlToImage: value["urlToImage"] ?? "",
          publishedAt: value["publishedAt"] ?? "",
          content: value["content"] ?? "");
      value["author"] != null ? newsList.add(articleModel) : "";
    });
  }
}
