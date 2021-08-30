import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_movie_videos.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/video.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/screens/video_player_screen.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/casts.dart';
import 'package:movie_app/ui/widgets/loader.dart';
import 'package:movie_app/ui/widgets/movie_info.dart';
import 'package:movie_app/ui/widgets/similar_movies.dart';
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
              _SliverAppBar(movie: widget.movie),
              _SliverBody(movie: widget.movie),
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
            ),
          );
        },
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  final Movie movie;

  const _SliverAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.mainColor,
      brightness: Brightness.dark,
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
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
                    '$imagesUrl/${movie.backPoster}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1, 0.9],
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
    );
  }
}

class _SliverBody extends StatelessWidget {
  static const title = 'OVERVIEW';
  final Movie movie;

  const _SliverBody({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movie.rating.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  RatingBar.builder(
                    itemSize: 10,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    initialRating: movie.rating / 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemBuilder: (context, _) => Icon(
                      EvaIcons.star,
                      color: AppColors.secondColor,
                    ),
                    unratedColor: AppColors.whiteColor,
                    onRatingUpdate: (rating) => print(rating),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                movie.overview,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            MovieInfo(id: movie.id),
            Casts(id: movie.id),
            SimilarMovies(id: movie.id),
          ],
        ),
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
        Navigator.push<void>(
          context,
          MaterialPageRoute(builder: (_) {
            if (videos.isEmpty) return VideoPlayerScreen();

            return VideoPlayerScreen(videoKey: videos.first.key);
          }),
        );
      },
    );
  }
}
