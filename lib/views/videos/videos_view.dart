import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/videos.dart';
import 'package:multimedia_app/providers/video_provider/video_provider.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/common_appbar.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/utils/custom_header_footer.dart';
import 'package:multimedia_app/widgets/offline_card.dart';
import 'package:multimedia_app/widgets/videos/loading_placeholder_video.dart';
import 'package:multimedia_app/widgets/videos/video_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideosView extends StatelessWidget {
  const VideosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideosProvider>(
      builder: (BuildContext context, videoProvider, Widget? child) {
        return Scaffold(
          appBar: commonAppbar("Videos"),
          backgroundColor: scaffoldColor,
          body: FutureBuilder(
              future: videoProvider.videosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPlaceholderVideo();
                } else if (snapshot.data != null) {
                  return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      footer: customFooter(),
                      header: customHeader(),
                      onRefresh: () => videoProvider.refreshVideos(),
                      onLoading: () => videoProvider.loadMoreVideos(),
                      controller: videoProvider.loadMoreController,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount: videoProvider.videosList.length,
                          itemBuilder: (context, index) {
                            Video video = videoProvider.videosList[index];
                            return VideoCard(
                              video: video,
                              onTapHeart: () => videoProvider.likeUnlike(index,context),
                            );
                          }));
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
