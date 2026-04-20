import 'dart:convert';


import 'package:addis_news/models/slider_model.dart';
import 'package:http/http.dart' as http;

class Slider {
  List<SliderModel> sliders = [];

  Future<void> getSlider() async {
    try {
      final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=3ef354ae562f454690be120ea7da6a2f",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData["status"] == "ok") {
          sliders.clear(); // important to avoid duplicates

          for (var e in jsonData["articles"]) {
            if (e["urlToImage"] != null && e["description"] != null) {
              sliders.add(
                SliderModel(
                  author: e["author"],
                  title: e["title"],
                  description: e["description"],
                  url: e["url"],
                  urlToImage: e["urlToImage"],
                  content: e["content"],
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
