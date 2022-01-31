import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/wideget.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;

  CategorieScreen({required this.categorie});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<WallpaperModel> wallpapers = [];

  getCategorieWallpaper( String query) async {
    var res = await http
        .get(Uri.parse(
        "https://api.pexels.com/v1/search?query=${widget.categorie}&page=1&per_page=15"),
        headers: {"Authorization":"563492ad6f91700001000001ac2c0e40062e42de805dcfd3bc1fcc53"}
    );
    Map <String, dynamic> jsondata =jsonDecode(res.body);
    jsondata["photos"].forEach(
            (element){
          WallpaperModel wallpaperModel=  WallpaperModel.fromMap(element);
          wallpapers.add(wallpaperModel);
        });
    setState(() {
    });
  }

  @override
  void initState() {
    getCategorieWallpaper(widget.categorie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: wallpaperList(wallpapers, context),
      ),
    );
  }
}