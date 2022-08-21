import 'dart:typed_data';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;
  final int id;

  const ImageView({Key? key, required this.imageUrl, required this.id})
      : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  void _askPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Permission.storage.request();
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void showBottomSheetOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  "What would you like to do?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setHomeScreenWallpaper();
                },
                child: const ListTile(
                  leading: Icon(Icons.image),
                  title: Text("SET WALLPAPER"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setLockScreenWallpaper();
                },
                child: const ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("SET LOCK SCREEN"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setBothScreensWallpaper();
                },
                child: const ListTile(
                  leading: Icon(Icons.app_blocking_outlined),
                  title: Text("SET BOTH"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _save();
                },
                child: const ListTile(
                  leading: Icon(Icons.download),
                  title: Text("SAVE TO MEDIA"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void setLockScreenWallpaper() async {
    String url = widget.imageUrl;
    var cachedImage = await DefaultCacheManager().getSingleFile(url);
    var result;
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
          cachedImage.path, AsyncWallpaper.LOCK_SCREEN);
    } catch (e) {
      print(e);
      result = 'Failed to get wallpaper.';
    }
    print(result.toString());
  }

  void setBothScreensWallpaper() async {
    String url = widget.imageUrl;
    var cachedImage = await DefaultCacheManager().getSingleFile(url);
    var result;
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
          cachedImage.path, AsyncWallpaper.BOTH_SCREENS);
    } catch (e) {
      print(e);
      result = 'Failed to get wallpaper.';
    }
    print(result.toString());
  }

  void setHomeScreenWallpaper() async {
    String url = widget.imageUrl;
    var cachedImage = await DefaultCacheManager().getSingleFile(url);
    var result;
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
          cachedImage.path, AsyncWallpaper.HOME_SCREEN);
    } catch (e) {
      print(e);
      result = 'Failed to get wallpaper.';
    }
    print(result.toString());
  }

  void _save() async {
    _askPermission();
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    // return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imageUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 24),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Share.share(
                        "Check out this wallpaper from @PexelsApi ${widget.imageUrl}");
                  },
                  child: const Icon(
                    Icons.share,
                    color: Colors.white60,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 24),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white60,
                  child: TextButton(
                    onPressed: () {
                      showBottomSheetOptions();
                    },
                    child: const Icon(
                      Icons.download,
                      color: Colors.black87,
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                const Icon(
                  Icons.favorite_border,
                  color: Colors.white60,
                  size: 26,
                )
              ],
            ),
          ),
          //container in widget.dart
        ],
      ),
    );
  }
}
