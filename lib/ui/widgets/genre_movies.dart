import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/get_movies_by_genre_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/screens/details_screen.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/loader.dart';
import 'package:movie_app/utils/consts.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;

  const GenreMovies({Key? key, required this.genreId}) : super(key: key);

  @override
  _GenreMoviesState createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  @override
  void initState() {
    super.initState();

    moviesByGenreBloc..getMoviesByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: moviesByGenreBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.error.isNotEmpty) {
            return AppError(error: data.error);
          }
          return _MoviesByGenre(movies: data.movies);
        }
        if (snapshot.hasError) {
          return AppError(error: snapshot.error.toString());
        }

        return Loader();
      },
    );
  }
}

class _MoviesByGenre extends StatelessWidget {
  final List<Movie> movies;

  const _MoviesByGenre({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: const Text(
          'No movies',
          style: TextStyle(color: AppColors.blackColor),
        ),
      );
    }

    return Container(
      height: 270,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => MovieDetailsScreen(movie: movie),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getMoviePoster(movie),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 120,
                    child: Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.4,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        movie.rating.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      RatingBar.builder(
                        itemSize: 8,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getMoviePoster(Movie movie) {
    if (movie.poster == null) {
      return Container(
        width: 120,
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.secondColor,
          borderRadius: BorderRadius.all(Radius.circular(2)),
          shape: BoxShape.rectangle,
        ),
        child: Icon(
          EvaIcons.filmOutline,
          color: AppColors.whiteColor,
          size: 50,
        ),
      );
    }

    return SizedBox(
      width: 120,
      height: 180,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.secondColor,
          borderRadius: BorderRadius.all(Radius.circular(2)),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: NetworkImage('$thumbs200Url${movie.poster}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
