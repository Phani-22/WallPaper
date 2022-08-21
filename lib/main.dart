import 'package:flutter/material.dart';
import 'package:wallpaper/views/home.dart';
import 'package:wallpaper/widget/widget.dart';

void main() {
  runApp(const WallpaperApp());
}

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: whiteColor,
        ),
      ),
      home: const Home(),
    );
  }
}
