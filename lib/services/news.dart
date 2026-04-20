import 'dart:convert';

import 'package:addis_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    try {
      final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?q=tesla&sortBy=publishedAt&apiKey=3ef354ae562f454690be120ea7da6a2f",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Total Results Found: ${jsonData['totalResults']}");
        print("API Response Code: ${response.statusCode}");
        print("API Response Body: ${response.body}");

        if (jsonData["status"] == "ok") {
          news.clear(); // important to avoid duplicates

          // inside services/news.dart
          for (var e in jsonData["articles"]) {
            // Only skip if the title or URL is missing (essential info)
            if (e["title"] != null && e["url"] != null) {
              news.add(
                ArticleModel(
                  author: e["author"] ?? "Addis News",
                  title: e["title"],
                  description:
                      e["description"] ??
                      "No description available for this article.",
                  url: e["url"],
                  // Use a placeholder image if the API doesn't provide one
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
