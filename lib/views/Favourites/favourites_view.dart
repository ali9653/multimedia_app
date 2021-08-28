import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/common_appbar.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/utils/screen_utils.dart';
import 'package:multimedia_app/views/Favourites/photo_favourites.dart';
import 'package:multimedia_app/views/Favourites/video_favourites.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({Key? key}) : super(key: key);

  Widget _favouriteButton(IconData icon, String title, BuildContext context,VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onTap ,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          color: cardColor,
          child: Container(
            alignment: Alignment.center,
            width: ScreenUtils.deviceWidth(100),
            height: ((MediaQuery.of(context).size.height - (MediaQueryData.fromWindow(window).padding.top + kToolbarHeight)) / 2) - ((55 / 2) + 18),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: ScreenUtils.deviceWidth(30),
                  color: Colors.white,
                ),
                Text(
                  title,
                  style: whiteW500.copyWith(fontSize: ScreenUtils.fontSize(25)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar("Favourites"),
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          _favouriteButton(CupertinoIcons.photo_fill, "Photos", context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavouritePhotos()));
          }),
          _favouriteButton(CupertinoIcons.play_rectangle_fill, "Videos", context, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteVideos()));
          })
        ],
      ),
    );
  }
}
