import 'package:meta/meta.dart';
import 'package:movie_app/model/movie.dart';

@immutable
class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse({
    required this.movies,
    required this.error,
  });

  factory MovieResponse.fromMap(Map<String, dynamic> map) {
    return MovieResponse(
      movies: List<Movie>.from(map['results']?.map((m) => Movie.fromMap(m))),
      error: '',
    );
  }

  MovieResponse.withError(String errorValue)
      : movies = [],
        error = errorValue;

  @override
  String toString() => 'MovieResponse(movies: $movies, error: $error)';
}
