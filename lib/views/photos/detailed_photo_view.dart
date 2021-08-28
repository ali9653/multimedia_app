import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimedia_app/models/photos.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/utils/constants.dart';
import 'package:multimedia_app/utils/screen_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedPhotoView extends StatelessWidget {
  final Photo photo;

  const DetailedPhotoView({Key? key, required this.photo}) : super(key: key);

  Widget _imageCard() {
    return Image(
      image: CachedNetworkImageProvider(photo.src!.large.toString()),
      fit: BoxFit.cover,
      width: ScreenUtils.deviceWidth(100),
    );
  }

  Widget _divider() {
    return Container(
      decoration: new BoxDecoration(
        color: shadowColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        shape: BoxShape.rectangle,
      ),
      margin: EdgeInsets.symmetric(vertical: 25),
      height: 4,
      width: ScreenUtils.deviceWidth(15),
    );
  }

  Widget _actionListTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      onTap: onTap,
      title: Text(
        title,
        style: whiteW500.copyWith(fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 15, color: Colors.blue),
      ),
    );
  }

  void _openLink(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      throw "Could not launch $url";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        brightness: Brightness.dark,
        backgroundColor: scaffoldColor,
      ),
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child:
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Column(
            children: [
              _imageCard(),
             // _divider(),
              _actionListTile("Photographer", photo.photographer.toString(), () {}),
              _actionListTile("Photographer Profile", photo.photographerUrl.toString(), () {
                _openLink(photo.photographerUrl.toString());
              }),
              _actionListTile("Photo URL", photo.url.toString(), () {
                _openLink(photo.url.toString());
              }),

            ],
          ),
        ),
      ),
    );
  }
}
