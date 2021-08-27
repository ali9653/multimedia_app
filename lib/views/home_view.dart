import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multimedia_app/providers/home_provider.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/views/photos_view.dart';
import 'package:multimedia_app/views/videos_view.dart';
import 'package:provider/provider.dart';

import 'Favourites/favourites_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  BottomNavigationBarItem _bottomButton(IconData iconData, String label) {
    return BottomNavigationBarItem(
        icon: Icon(
          iconData,
          size: 25,
        ),
        label: label.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (
        BuildContext ctx,
        homeProvider,
        Widget? child,
      ) {
        return WillPopScope(
          onWillPop: () async {
            if (homeProvider.currentIndex != 0) {
              homeProvider.changeTab(0);
              return false;
            } else {
              SystemNavigator.pop();
              return false;
            }
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                elevation: 0,
                brightness: Brightness.dark,
                backgroundColor: scaffoldColor,
              ),
            ),
            backgroundColor: scaffoldColor,
            bottomNavigationBar: Container(
              height: 55,
              child: BottomNavigationBar(
                onTap: (int index) => homeProvider.changeTab(index),
                backgroundColor: scaffoldColor,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.red,
                currentIndex: homeProvider.currentIndex,
                items: [
                  _bottomButton(CupertinoIcons.photo_fill, "Photos"),
                  _bottomButton(CupertinoIcons.play_rectangle_fill, "Videos"),
                  _bottomButton(CupertinoIcons.square_favorites_alt_fill, "Favourites"),
                ],
              ),
            ),
            body: IndexedStack(
              index: homeProvider.currentIndex,
              children: [PhotosView(), VideosView(), FavouritesView()],
            ),
          ),
        );
      },
    );
  }
}
