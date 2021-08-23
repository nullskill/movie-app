import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/model/genre.dart';

@immutable
class GenreResponse extends Equatable {
  final List<Genre> genres;
  final String error;
  GenreResponse({
    required this.genres,
    required this.error,
  });

  GenreResponse copyWith({
    List<Genre>? genres,
    String? error,
  }) {
    return GenreResponse(
      genres: genres ?? this.genres,
      error: error ?? this.error,
    );
  }

  factory GenreResponse.fromMap(Map<String, dynamic> map) {
    return GenreResponse(
      genres: List<Genre>.from(map['results']?.map((m) => Genre.fromMap(m))),
      error: '',
    );
  }

  GenreResponse.withError(String errorValue)
      : genres = List.empty(),
        error = errorValue;

  @override
  List<Object?> get props => [genres, error];

  @override
  String toString() => 'MovieResponse(movies: $genres, error: $error)';
}
