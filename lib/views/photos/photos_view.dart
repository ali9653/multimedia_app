import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/providers/photo_provider/photo_provider.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/common_appbar.dart';
import 'package:multimedia_app/utils/custom_header_footer.dart';
import 'package:multimedia_app/widgets/offline_card.dart';
import 'package:multimedia_app/widgets/photos/loading_placeholder_images.dart';
import 'package:multimedia_app/widgets/photos/photo_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({Key? key}) : super(key: key);

  @override
  _PhotosViewState createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
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
          appBar: commonAppbar("Photographs"),
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
                          return PhotoCard(
                            photo: photo,
                            onTapHeart: () => photoProvider.likeUnlike(index, context),
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
