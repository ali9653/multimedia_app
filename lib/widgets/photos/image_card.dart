import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/constants.dart';

class ImageCard extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTapHeart;

  const ImageCard({Key? key, required this.photo, required this.onTapHeart}) : super(key: key);

  Widget _imageCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image(
        image: CachedNetworkImageProvider(photo.src!.large.toString()),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _photographerCard() {
    return Positioned.fill(
      left: 6,
      bottom: 6,
      right: 6,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), shape: BoxShape.rectangle, color: shadowColor),
            child: Text(
              photo.photographer.toString(),
              style: whiteBold.copyWith(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ),
    );
  }

  Widget _favouriteIcon() {
    return Positioned.fill(
      child: Align(
          alignment: Alignment.topRight,
          child: Container(
              child: IconButton(
            splashRadius: 20,
            icon: Icon(
              photo.liked! ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              size: 30,
              color: photo.liked! ? Colors.red : Colors.white,
            ),
            onPressed: onTapHeart,
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: cardColor,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          children: [_imageCard(), _photographerCard(), _favouriteIcon()],
        ),
      ),
    );
  }
}
