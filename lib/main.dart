import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multimedia_app/providers/favourites_provides.dart';
import 'package:multimedia_app/providers/home_provider.dart';
import 'package:multimedia_app/providers/photo_provider/photos_provider.dart';
import 'package:multimedia_app/providers/video_provider/video_provider.dart';
import 'package:multimedia_app/views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhotosProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => VideosProvider()),
        ChangeNotifierProvider(create: (_) => FavouritesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
      ),
    );
  }
}
