import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/get_now_playing_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/loader.dart';
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
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.error.isNotEmpty) {
            return AppError(error: data.error);
          }
          return _NowPlaying(movies: data.movies);
        }
        if (snapshot.hasError) {
          return AppError(error: snapshot.error.toString());
        }

        return Loader();
      },
    );
  }
}

class _NowPlaying extends StatelessWidget {
  static const tmdbUrl = 'https://image.tmdb.org/t/p/original/';
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
        shape: IndicatorShape.circle(size: 5),
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: movies.take(5).length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Hero(
                    tag: movie.id,
                    child: SizedBox(
                      width: double.infinity,
                      height: 220,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              '$tmdbUrl${movies[index].backPoster}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                              movie.title,
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
