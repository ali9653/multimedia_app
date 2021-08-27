import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/providers/photo_provider/photos_provider.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/utils/custom_header_footer.dart';
import 'package:multimedia_app/widgets/offline_card.dart';
import 'package:multimedia_app/widgets/photos/image_card.dart';
import 'package:multimedia_app/widgets/photos/loading_placeholder_images.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ImagesView extends StatefulWidget {
  const ImagesView({Key? key}) : super(key: key);

  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  late Future _photosFuture;

  @override
  void initState() {
    _photosFuture = Provider.of<PhotosProvider>(context, listen: false).fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosProvider>(
      builder: (BuildContext context, photoProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            brightness: Brightness.dark,
            backgroundColor: scaffoldColor,
            title: Text(
              "Photographs",
              style: whiteW500.copyWith(fontSize: 22),
            ),
          ),
          backgroundColor: scaffoldColor,
          body: FutureBuilder(
              future: _photosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPlaceHolderImages();
                } else if (snapshot.data != null) {
                  return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    footer: customFooter(),
                    header: customHeader(),
                    controller: photoProvider.loadMoreController,
                    onRefresh: () => photoProvider.refreshPhotos(),
                    onLoading: () => photoProvider.loadMorePhotos(),
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: photoProvider.photosList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3, childAspectRatio: 4 / 5),
                        itemBuilder: (context, index) {
                          Photo photo = photoProvider.photosList[index];
                          return ImageCard(
                            photo: photo,
                            onTapHeart: () => photoProvider.likeUnlike(index,context),
                          );
                        }),
                  );
                } else if (snapshot.connectionState != ConnectionState.active) {
                  return OfflineCard();
                } else {
                  return Container();
                }
              }),
        );
      },
    );
  }
}
