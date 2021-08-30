import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final YoutubePlayerController controller;

  const VideoPlayerScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(controller: widget.controller),
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
