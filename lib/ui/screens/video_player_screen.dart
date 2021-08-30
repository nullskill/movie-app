import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoKey;

  const VideoPlayerScreen({Key? key, this.videoKey = ''}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  static const noVideosTitle = 'No videos';
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();

    if (widget.videoKey == '') return;

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          Center(
            child: _controller == null
                ? Text(
                    noVideosTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                    ),
                  )
                : YoutubePlayer(controller: _controller!),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(EvaIcons.closeCircle),
              color: AppColors.whiteColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
