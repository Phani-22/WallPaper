import 'package:flutter/material.dart';
import 'package:wallpaper/views/image_view.dart';

import '../models/wallpaper_model.dart';

/*
Widget getContainer() {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.bottomCenter,
    child: GestureDetector(
      onTap: () {
        _save();
        Navigator.pop(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1B1B).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white60, width: 1),
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                  ),
                ),
                child: Column(
                  children: const [
                    Text(
                      "Set Wallpaper",
                      style: TextStyle(
                          color: Colors.white60, fontSize: 16),
                    ),
                    Text(
                      "Image will be saved in gallery",
                      style: TextStyle(
                          color: Colors.white60, fontSize: 10),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 50)
        ],
      ),
    ),
  )
}
*/

// app bar text
Widget brandName() {
  return RichText(
    text: const TextSpan(
      text: '',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      children: [
        TextSpan(
          text: "Wall",
          style: TextStyle(color: Colors.black87),
        ),
        TextSpan(
          text: "paper",
          style: TextStyle(color: Colors.blue),
        )
      ],
    ),
  );
}

// pictures showing grid view
Widget wallPapersList(List<WallpaperModel> wallpapers, context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const ClampingScrollPhysics(),
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imageUrl: wallpaper.src.portrait,
                    id: wallpaper.photographerId,
                  ),
                ),
              );
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  wallpaper.src.portrait,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

// primary swatch color
const MaterialColor whiteColor = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
