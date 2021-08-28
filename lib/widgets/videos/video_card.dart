import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/videos.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/utils/screen_utils.dart';
import 'package:multimedia_app/views/videos/detailed_video_view.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  final VoidCallback onTapHeart;

  const VideoCard({Key? key, required this.video, required this.onTapHeart}) : super(key: key);

  final double _borderRadius = 10;


  Widget playButton () {
    return Positioned.fill(
      child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(10),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
               color: Colors.black.withOpacity(0.8)
              ),
              child: Icon(Icons.play_arrow,color: Colors.white,size: 40,))),
    );
  }

  Widget _thumbnailCard() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(_borderRadius), topRight: Radius.circular(_borderRadius)),
          child: Image(
            image: CachedNetworkImageProvider(video.image.toString()),
            fit: BoxFit.cover,
            height: ScreenUtils.deviceHeight(25),
            width: ScreenUtils.deviceWidth(100),
          ),
        ),
        _favouriteIcon(),
        playButton()
      ],
    );
  }

  Widget _userCard() {
    return Container(
        width: ScreenUtils.deviceWidth(100),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_borderRadius), bottomRight: Radius.circular(_borderRadius)),
            shape: BoxShape.rectangle,
            color: shadowColor),
        child: Text(
          video.user!.name.toString(),
          style: whiteBold.copyWith(fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget _favouriteIcon() {
    return Positioned.fill(
      child: Align(
          alignment: Alignment.topRight,
          child: Container(
              child: IconButton(
            splashRadius: 20,
            icon: Icon(
              video.liked! ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              size: 30,
              color: video.liked! ? Colors.red : Colors.white,
            ),
            onPressed: onTapHeart,
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedVideoView(videoURL: video.videoFiles![0].link.toString(),)));
      },
      child: Container(
        color: Colors.transparent,
        child: Card(
          color: cardColor,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [_thumbnailCard(), _userCard()],
          ),
        ),
      ),
    );
  }
}
