

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';



class ImageView extends StatefulWidget {
  final String imageUrl;

  const ImageView({Key? key,required this.imageUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {


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
                child: Image.network(widget.imageUrl,fit: BoxFit.cover,)),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               GestureDetector(
            onTap: (){
              _setWallpaper();


            },
                 child: Stack(
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width / 2,
                       height: 50,
                       decoration: BoxDecoration(
                         color: Color(0xff1C1B1B).withOpacity(0.8),
                         borderRadius: BorderRadius.circular(30),
                       ),

                     ),
                     Container(
                       width: MediaQuery.of(context).size.width / 2,
                       height: 50,
                       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.white54, width: 1),
                           borderRadius: BorderRadius.circular(30),
                           gradient: const LinearGradient(
                               colors: [
                                 Color(0x36FFFFFF),
                                 Color(0x0FFFFFFF)
                               ],
                           )),
                       child: const Text("Set Wallpaper",style:   TextStyle(
                         color: Colors.white54,fontSize: 16,
                       ),),

                     ),
                   ],
                 ),
               ),
                const SizedBox(height: 16.0,),
                 GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: const Text(
                    "Cancel",style: TextStyle(
                    color: Colors.white
                ),
                ),
                 ),
                const SizedBox(height: 50.0,)

              ],
            ),
          )
        ],
      ),
    );
  }

  _setWallpaper() async{
    int location = WallpaperManager.HOME_SCREEN;
    var file =await DefaultCacheManager().getSingleFile(widget.imageUrl);
    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    _showToast();

  }

   _showToast() {
     Fluttertoast.showToast(
         msg: "Wallpaper Successfully set",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.black,
         textColor: Colors.white,
         fontSize: 16.0
     );


  }

}


