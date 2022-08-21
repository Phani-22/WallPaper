import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/views/category.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  final String imgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(categoryName: title),
            ),
          );
        },
        child: Container(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                  imageUrl: imgUrl,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomLeft,
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
