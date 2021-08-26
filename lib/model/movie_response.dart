import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/model/movie.dart';

@immutable
class MovieResponse extends Equatable {
  final List<Movie> movies;
  final String error;
  MovieResponse({
    required this.movies,
    required this.error,
  });

  MovieResponse copyWith({
    List<Movie>? movies,
    String? error,
  }) {
    return MovieResponse(
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }

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
  List<Object?> get props => [movies, error];

  @override
  String toString() => 'MovieResponse(movies: $movies, error: $error)';
}
