import 'dart:convert';
import 'package:addis_news/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class News {
  List<ArticleModel> news = [];
  final String? apiKey = dotenv.env['NEWS_API_KEY'];

  // Fetch general news (default)
  Future<void> getNews() async {
    await _fetchNewsFromUrl(
      "https://newsapi.org/v2/everything?q=tesla&from=2026-03-22&sortBy=publishedAt&apiKey=$apiKey",
    );
  }

  // Fetch Breaking News
  Future<void> getBreakingNews() async {
    await _fetchNewsFromUrl(
      "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=$apiKey",
    );
  }

  // Fetch Trending News
  Future<void> getTrendingNews() async {
    await _fetchNewsFromUrl(
      "https://newsapi.org/v2/top-headlines?country=us&sortBy=popularity&apiKey=$apiKey",
    );
  }

  // Private helper function to fetch and parse news
  Future<void> _fetchNewsFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] == "ok") {
          news.clear();

          for (var e in jsonData["articles"]) {
            if (e["title"] != null && e["url"] != null) {
              news.add(
                ArticleModel(
                  author: e["author"] ?? "Addis News",
                  title: e["title"],
                  description:
                      e["description"] ??
                      "No description available for this article.",
                  url: e["url"],
                  urlToImage:
                      e["urlToImage"] ??
                      "https://images.unsplash.com/photo-1504711434969-e33886168f5c",
                  content: e["content"] ?? "",
                ),
              );
            }
          }
        }
      } else {
        print("API ERROR: ${response.statusCode}");
      }
    } catch (e) {
      print("NETWORK ERROR: $e");
    }
  }
}
