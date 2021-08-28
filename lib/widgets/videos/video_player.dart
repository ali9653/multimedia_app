import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String videoURL;
  const VideoPlayer({Key? key, required this.videoURL}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {


  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = new FlickManager(
      autoPlay: true,
      autoInitialize: true,
      videoPlayerController: VideoPlayerController.network(widget.videoURL),
    );
    flickManager.flickControlManager!.enterFullscreen();
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        flickManager.flickControlManager!.exitFullscreen();
        Navigator.pop(context);
        return true;
      },
      child: Container(
        child: FlickVideoPlayer(
          wakelockEnabled: true,
          wakelockEnabledFullscreen: true,
          flickManager: flickManager,
        ),
      ),
    );
  }
}
