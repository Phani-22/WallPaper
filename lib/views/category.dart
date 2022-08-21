import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/widget/widget.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<WallpaperModel> wallpapers = [];

  void getSearchedWallpapers(String querySearch) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$querySearch&per_page=15?page=1"),
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel(
        SrcModel(
          element["src"]["original"],
          element["src"]["portrait"],
          element["src"]["small"],
        ),
        element["photographer"],
        element["photographer_id"],
        element["photographer_url"],
      );
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: brandName(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 16),
              wallPapersList(wallpapers, context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getSearchedWallpapers(widget.categoryName);
    super.initState();
  }
}
