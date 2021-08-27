import 'package:flutter/cupertino.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/providers/favourites_provides.dart';
import 'package:multimedia_app/providers/home_provider.dart';
import 'package:multimedia_app/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhotosProvider with ChangeNotifier {
  List<Photo> photosList = <Photo>[];
  RefreshController loadMoreController = RefreshController(initialRefresh: false);
  var page = 1;

  Future<List<Photo>> fetchPhotos() async {
    List<Photo>? photos = await ApiService.getPhotos(page);
    if (photos!.isNotEmpty) {
      this.photosList = photos;
      return photosList;
    } else {
      return <Photo>[];
    }
  }

  void addOrRemoveFromFavourites (bool val, BuildContext context, Photo photo) {
    var favouritesProvider = Provider.of<FavouritesProvider>(context, listen: false).photosList;
    if(val) {
      favouritesProvider.add(photo);
    } else {
      favouritesProvider.remove(photo);
    }

  }

  void likeUnlike(int index, BuildContext context) {
    this.photosList[index].liked = !this.photosList[index].liked!;
    addOrRemoveFromFavourites(this.photosList[index].liked!, context, this.photosList[index]);
    notifyListeners();
  }

  void refreshPhotos() async {
    page = 0;
    List<Photo>? photos = await ApiService.getPhotos(page);
    if (photos!.isNotEmpty) {
      this.photosList = photos;
      loadMoreController.refreshCompleted();
      notifyListeners();
    } else {
      loadMoreController.refreshCompleted();
      notifyListeners();
    }
  }

  void loadMorePhotos() async {
    page++;
    List<Photo>? photos = await ApiService.getPhotos(page);
    if (photos!.isNotEmpty) {
      this.photosList.addAll(photos);
      loadMoreController.loadComplete();
      notifyListeners();
    } else {
      loadMoreController.loadComplete();
      notifyListeners();
    }
  }


}
