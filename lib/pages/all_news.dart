// pages/all_news.dart
import 'package:addis_news/models/article_model.dart';
import 'package:addis_news/services/news.dart';
import 'package:flutter/material.dart';
import 'package:addis_news/pages/blog_tile.dart';

class AllNews extends StatefulWidget {
  final String type; // "breaking" or "trending"
  const AllNews({super.key, required this.type});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<ArticleModel> articles = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  void loadNews() async {
    News newsService = News();

    if (widget.type == "breaking") {
      await newsService.getBreakingNews(); // implement this in News
    } else if (widget.type == "trending") {
      await newsService.getTrendingNews(); // implement this in News
    }

    if (mounted) {
      setState(() {
        articles = newsService.news;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.type == "breaking" ? "Breaking News" : "Trending News",
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : articles.isEmpty
          ? const Center(child: Text("No news available"))
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return BlogTile(
                  url: articles[index].url ?? "",
                  imageUrl: articles[index].urlToImage ?? "",
                  title: articles[index].title ?? "No Title",
                  description: articles[index].description ?? "No Description",
                );
              },
            ),
    );
  }
}
