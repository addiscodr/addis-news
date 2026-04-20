import 'package:addis_news/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];

  // Business
  CategoryModel business = CategoryModel();
  business.categoryName = "Business";
  business.image = "assets/images/business.jpg";
  category.add(business);

  // Entertainment
  CategoryModel entertainment = CategoryModel(); // New instance!
  entertainment.categoryName = "Entertainment";
  entertainment.image = "assets/images/entertainment.jpg";
  category.add(entertainment);

  // General
  CategoryModel general = CategoryModel(); // New instance!
  general.categoryName = "General";
  general.image = "assets/images/general.jpg";
  category.add(general);

  // Health
  CategoryModel health = CategoryModel(); // New instance!
  health.categoryName = "Health";
  health.image = "assets/images/health.jpg";
  category.add(health);

  // Sport
  CategoryModel sport = CategoryModel(); // New instance!
  sport.categoryName = "Sports";
  sport.image = "assets/images/sport.jpg";
  category.add(sport);

  return category;
}
