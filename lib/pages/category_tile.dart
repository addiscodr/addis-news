import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String image;
  final String categoryName;
  const CategoryTile({
    super.key,
    required this.image,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(6),
            child: Image.asset(
              image,
              width: 120,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
