import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/categories_model.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/views/search.dart';
import 'package:wallpaper/widget/category_tile.dart';
import 'package:wallpaper/widget/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  void getTrendingWallpapers() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=60?page=1"),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: brandName(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFe9edf5),
                  borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                          hintText: "Search Wallpapers",
                          border: InputBorder.none),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      String searchText = searchController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Search(
                            searchQuery: searchText,
                          ),
                        ),
                      );
                      FocusManager.instance.primaryFocus?.unfocus();
                      searchController.text = "";
                    },
                    child: Container(
                      child: const Icon(Icons.search),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Featured",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 170,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    imgUrl: categories[index].imgUrl,
                    title: categories[index].categoryName,
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Popular",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            wallPapersList(wallpapers, context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
