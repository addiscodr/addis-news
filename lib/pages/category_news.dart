import 'package:addis_news/models/show_category_model.dart';
import 'package:addis_news/pages/article_view.dart';
import 'package:addis_news/pages/show_category.dart';
import 'package:addis_news/services/show_category_news.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  String name;

  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // 1. Flutter handles the back arrow automatically, but we can customize it:
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // 2. This is the "magic" property that forces the title to center
        // regardless of the size of the leading or trailing icons.
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min, // Constrains the row to its content
          children: [
            const Text(
              "ADDIS",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            
            const Text(
              "NEWS",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : categories.isEmpty
          ? const Center(child: Text("No news found for this category"))
          : ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArticleView(blogUrl: categories[index].url ?? ""),
                      ),
                    );
                  },
                  child: ShowCategory(
                    image: categories[index].urlToImage!,
                    description: categories[index].description!,
                    title: categories[index].title!,
                    url: categories[index].url!,
                  ),
                );
              },
            ),
    );
  }
}
