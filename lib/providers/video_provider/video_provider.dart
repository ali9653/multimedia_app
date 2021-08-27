import 'package:flutter/cupertino.dart';
import 'package:multimedia_app/models/videos.dart';
import 'package:multimedia_app/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../favourites_provides.dart';

class VideosProvider with ChangeNotifier {
  List<Video> videosList = <Video>[];
  RefreshController loadMoreController = RefreshController(initialRefresh: false);
  var page = 1;

  Future<List<Video>> fetchVideos() async {
    List<Video>? videos = await ApiService.getVideos(page);
    if (videos!.isNotEmpty) {
      this.videosList = videos;
      print(videosList.length.toString() + " video length");
      return videosList;
    } else {
      return <Video>[];
    }
  }


  void addOrRemoveFromFavourites (bool val, BuildContext context, Video video) {
    var favouritesProvider = Provider.of<FavouritesProvider>(context, listen: false).videosList;
    if(val) {
      favouritesProvider.add(video);
    } else {
      favouritesProvider.remove(video);
    }

  }

  void likeUnlike(int index, BuildContext context) {
    this.videosList[index].liked = !this.videosList[index].liked!;
    addOrRemoveFromFavourites(this.videosList[index].liked!, context, this.videosList[index]);
    notifyListeners();
  }

  void refreshVideos() async {
    page = 0;
    List<Video>? videos = await ApiService.getVideos(page);
    if (videos!.isNotEmpty) {
      this.videosList = videos;
      loadMoreController.refreshCompleted();
      notifyListeners();
    } else {
      loadMoreController.refreshCompleted();
      notifyListeners();
    }
  }

  void loadMoreVideos() async {
    page++;
    List<Video>? videos = await ApiService.getVideos(page);
    if (videos!.isNotEmpty) {
      this.videosList.addAll(videos);
      loadMoreController.loadComplete();
      notifyListeners();
    } else {
      loadMoreController.loadComplete();
      notifyListeners();
    }
  }
}
