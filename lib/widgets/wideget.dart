import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/full_view.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87),
      ),
      Text(
        "App",
        style: TextStyle(color: Colors.blue),
      )
    ],
  );
}
Widget about() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        "Made By",
        style: TextStyle(color: Colors.black87,fontSize: 16, ),

      ),
      Text(
        "  Zihad",
        style: TextStyle(color: Colors.blue,fontSize: 16),
      )
    ],
  );
}

Widget wallpaperList(List<WallpaperModel> wallpapers,BuildContext context){

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> ImageView(imageUrl: wallpaper.src.portrait)));
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(wallpaper.src.portrait,
                      fit: BoxFit.cover,),
                  ),
        ),
              ),
            ));

      }).toList()
    ),


  );

}
