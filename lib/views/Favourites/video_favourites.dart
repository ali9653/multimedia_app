import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/videos.dart';
import 'package:multimedia_app/providers/favourites_provides.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/common_appbar.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/widgets/videos/video_card.dart';
import 'package:provider/provider.dart';

class FavouriteVideos extends StatelessWidget {
  const FavouriteVideos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesProvider>(
      builder: (BuildContext context, favouriteProvider, Widget? child) {
        return Scaffold(
            appBar: commonAppbar("Favourite Videos"),
            backgroundColor: scaffoldColor,
            body: favouriteProvider.videosList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      "No favourites",
                      style: whiteW500.copyWith(fontSize: 25),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: favouriteProvider.videosList.length,
                    itemBuilder: (context, index) {
                      Video video = favouriteProvider.videosList[index];
                      return VideoCard(
                        video: video,
                        onTapHeart: () => null,
                      );
                    }));
      },
    );
  }
}
