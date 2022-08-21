import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/models/wallpaper_model.dart';
import 'package:wallpaper/widget/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;

  const Search({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
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
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: const Icon(Icons.search),
                      ),
                    )
                  ],
                ),
              ),
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
    getSearchedWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
    super.initState();
  }
}
