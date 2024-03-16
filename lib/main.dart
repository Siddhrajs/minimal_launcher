import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('com.example.wallpaper');
  String wallpaperPath = '';

  @override
  void initState() {
    super.initState();
    _getWallpaperPath();
  }

  Future<void> _getWallpaperPath() async {
    try {
      final String result = await platform.invokeMethod('getWallpaperPath');
      setState(() {
        wallpaperPath = result;
      });
    } on PlatformException catch (e) {
      print("Failed to get wallpaper: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper Example'),
      ),
      body: Center(
        child: wallpaperPath.isNotEmpty
            ? Image.file(
                File(wallpaperPath),
                fit: BoxFit.cover,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
