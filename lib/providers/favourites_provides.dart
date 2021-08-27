import 'package:flutter/cupertino.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/models/videos.dart';

class FavouritesProvider with ChangeNotifier {

  List<Video> videosList = <Video>[];
  List<Photo> photosList = <Photo>[];

}