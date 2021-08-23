import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_now_playing_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:page_indicator/page_indicator.dart';

/// The screen for displaying list of movies in theatres
class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();

    nowPlayingMoviesBloc.getPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error.isNotEmpty) {
            return _Error(error: snapshot.data!.error);
          }
          return _NowPlaying(movies: snapshot.data!.movies);
        }
        if (snapshot.hasError) {
          return _Error(error: snapshot.error.toString());
        }

        return _Loader();
      },
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _Error extends StatelessWidget {
  final String error;

  const _Error({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }
}

class _NowPlaying extends StatelessWidget {
  final List<Movie> movies;
  final PageController _pageController =
      PageController(viewportFraction: 1, keepPage: true);

  _NowPlaying({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: const Text(
          'No movies',
          style: TextStyle(
            color: AppColors.blackColor,
          ),
        ),
      );
    }

    return Container(
      height: 220,
      child: PageIndicatorContainer(
        length: movies.take(5).length,
        align: IndicatorAlign.bottom,
        padding: const EdgeInsets.all(5),
        indicatorSpace: 8,
        indicatorColor: AppColors.titleColor,
        indicatorSelectorColor: AppColors.secondColor,
        shape: IndicatorShape.roundRectangleShape(size: Size(5, 5)),
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: movies.take(5).length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Hero(
                    tag: movies[index].id,
                    child: SizedBox(
                      width: double.infinity,
                      height: 220,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/original/${movies[index].backPoster}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0, 0.9],
                        colors: [
                          AppColors.mainColor.withOpacity(1),
                          AppColors.mainColor.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: const Icon(
                      FontAwesomeIcons.playCircle,
                      color: AppColors.secondColor,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movies[index].title,
                              style: const TextStyle(
                                height: 1.5,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
