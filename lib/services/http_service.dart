import 'dart:convert';
import 'dart:io';
import 'package:exam_setstate/models/articles_list_news_model.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'http_helper.dart';

//https://randomuser.me/api?results=10&page=2

class Network {
  static String BASE = "newsapi.org";

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri);
    return response.body;
  }

  /* Http Apis*/
  static String API_NEWS_INFOS = "/v2/everything";

/* Http Params */
  static Map<String, String> paramsArticle() {
    Map<String, String> params = {};
    params.addAll({
      'q': "tesla",
      'sortBy': 'publishedAt',
      'apiKey': 'eb1ec43e218649538cc445c8eb59df7c'
    });
    return params;
  }

/* Http Parsing */
  static List<Article> parseArticles(String response) {
    dynamic json = jsonDecode(response);
    return ArticlesListNews .fromJson(json).articles;
  }
}
