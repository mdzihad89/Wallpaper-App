import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widgets/wideget.dart';
import 'package:http/http.dart' as http;

import 'categorie.dart';
import 'full_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers=[];
  TextEditingController searchController=TextEditingController();


  getTrendingWallpaper() async {
    var res = await http
        .get(Uri.parse(
        "https://api.pexels.com/v1/curated?page=1&per_page=15"),
        headers: {"Authorization":"563492ad6f91700001000001ac2c0e40062e42de805dcfd3bc1fcc53"}
    );
    Map<String, dynamic> jsonData = jsonDecode(res.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);

    });

    setState(() {});
  }



  @override
  void initState() {
    categories = getCategories();
    getTrendingWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(32.0)),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row( 
                children:  [
                   Expanded(
                    child: TextField(
                      controller: searchController,

                      decoration: const InputDecoration(
                          hintText: "Search Wallpaper...",
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Search(
                            searchQuery: searchController.text,
                          )));
                    },
                      child: Container(
                          child: Icon(Icons.search)))
                ],
              ),

            ),
            Container(
              height: 30.0,
              child: about(),
            ),
            const SizedBox(height: 16,),

            Container(
              height: 60.0,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categorieName,
                      imageUrl: categories[index].imageUrl,
                    );
                  }),
            ),
            const SizedBox(height: 16,),
            wallpaperList(wallpapers ,context)
          ],
        )),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imageUrl, title;

  const CategoriesTile({Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(
              builder: (context)=> CategorieScreen(
                categorie: title.toLowerCase(),
              )
        ));

      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
