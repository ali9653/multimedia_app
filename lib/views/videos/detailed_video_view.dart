import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multimedia_app/utils/colors.dart';
import 'package:multimedia_app/widgets/videos/video_player.dart';

class DetailedVideoView extends StatefulWidget {
  final String videoURL;
  const DetailedVideoView({Key? key, required this.videoURL}) : super(key: key);

  @override
  _DetailedVideoViewState createState() => _DetailedVideoViewState();
}

class _DetailedVideoViewState extends State<DetailedVideoView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: VideoPlayer(videoURL: widget.videoURL),
    );
  }
}
