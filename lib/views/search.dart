import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/wideget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {


  final String searchQuery;

  const Search({Key? key,required this.searchQuery}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search> {


  List<WallpaperModel> wallpapers=[];
  TextEditingController searchController=TextEditingController();


  getSearchWallpaper( String query) async {
    var res = await http
        .get(Uri.parse(
        "https://api.pexels.com/v1/search?query=$query&page=1&per_page=15"),
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
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text=widget.searchQuery;
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
                          getSearchWallpaper(searchController.text);

                        },
                        child: Container(
                            child: Icon(Icons.search)))
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              wallpaperList(wallpapers ,context)
            ],
          ),
        ),
      ),
    );
  }
}
