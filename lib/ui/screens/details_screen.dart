import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movie_videos.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/video.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/loader.dart';
import 'package:movie_app/utils/consts.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();

    movieVideosBloc..getMovieVideos(widget.movie.id);
  }

  @override
  void dispose() {
    movieVideosBloc..drainStream();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Builder(
        builder: (context) {
          return SliverFab(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.mainColor,
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: NetworkImage(
                                '$imagesUrl/${widget.movie.backPoster}',
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.blackColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.blackColor.withOpacity(0.9),
                                AppColors.blackColor.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              expandedHeight: 200,
              floatingPosition: FloatingPosition(right: 20),
              floatingWidget: StreamBuilder<VideoResponse>(
                stream: movieVideosBloc.subject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    if (data.error.isNotEmpty) {
                      return AppError(error: data.error);
                    }
                    return _Video(videos: data.videos);
                  }
                  if (snapshot.hasError) {
                    return AppError(error: snapshot.error.toString());
                  }

                  return Loader();
                },
              ));
        },
      ),
    );
  }
}

class _Video extends StatelessWidget {
  final List<Video> videos;

  const _Video({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.secondColor,
      child: Icon(Icons.play_arrow),
      onPressed: () {
        return null;
      },
    );
  }
}
