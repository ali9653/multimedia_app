import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/providers/favourites_provides.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/common_appbar.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/widgets/photos/photo_card.dart';
import 'package:provider/provider.dart';

class FavouritePhotos extends StatelessWidget {
  const FavouritePhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
      builder: (BuildContext context, favouriteProvider, Widget? child) {
        return Scaffold(
          appBar: commonAppbar("Favourite Photos"),
          backgroundColor: scaffoldColor,
          body:
          favouriteProvider.photosList.isEmpty ? Container(
            alignment: Alignment.center,
            child: Text("No favourites",style: whiteW500.copyWith(fontSize: 25),),
          ) :
          GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: favouriteProvider.photosList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3, childAspectRatio: 4 / 5),
              itemBuilder: (context, index) {
                Photo photo = favouriteProvider.photosList[index];
                return PhotoCard(
                  photo: photo,
                  onTapHeart: () => null,
                );
              }),
        );
      },
    );
  }
}
