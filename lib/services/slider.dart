import 'dart:convert';

import 'package:addis_news/models/slider_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Slider {
  List<SliderModel> sliders = [];
  final String? apiKey = dotenv.env['NEWS_API_KEY'];

  Future<void> getSlider() async {
    try {
      final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] == "ok") {
          sliders.clear(); // important to avoid duplicates

          for (var e in jsonData["articles"]) {
            // Relaxed condition: as long as there is a title and a link, we can show it

            if (e["urlToImage"] != null && e["description"] != null) {
              if (e["title"] != null && e["urlToImage"] != null) {
                sliders.add(
                  SliderModel(
                    author: e["author"] ?? "Trending",
                    title: e["title"],
                    description: e["description"] ?? "", // Fallback
                    url: e["url"],
                    urlToImage: e["urlToImage"], // Placeholder
                    content: e["content"] ?? "",
                  ),
                );
              }
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
