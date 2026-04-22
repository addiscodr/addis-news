import 'dart:convert';

import 'package:addis_news/models/show_category_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];
  final String? apiKey = dotenv.env['NEWS_API_KEY'];

  Future<void> getCategoriesNews(String category) async {
    final url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData["status"] == "ok") {
        categories.clear(); // important to avoid duplicates

        for (var e in jsonData["articles"]) {
          if (e["title"] != null) {
            categories.add(
              ShowCategoryModel(
                author: e["author"] ?? "Category News",
                title: e["title"],
                description:
                    e["description"] ??
                    "Tap to read more..."
                        "No description available", // Fallback
                url: e["url"],
                urlToImage:
                    e["urlToImage"] ??
                    "https://images.unsplash.com/photo-1504711434969-e33886168f5c", // Placeholder
                content: e["content"] ?? "",
              ),
            );
          }
        }
      }
    }
  }
}
