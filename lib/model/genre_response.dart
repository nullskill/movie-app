import 'package:meta/meta.dart';
import 'package:movie_app/model/genre.dart';

@immutable
class GenreResponse {
  final List<Genre> genres;
  final String error;

  GenreResponse({
    required this.genres,
    required this.error,
  });

  factory GenreResponse.fromMap(Map<String, dynamic> map) {
    return GenreResponse(
      genres: List<Genre>.from(map['genres']?.map((m) => Genre.fromMap(m))),
      error: '',
    );
  }

  GenreResponse.withError(String errorValue)
      : genres = [],
        error = errorValue;

  @override
  String toString() => 'MovieResponse(movies: $genres, error: $error)';
}
