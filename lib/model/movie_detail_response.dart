import 'package:flutter/foundation.dart';
import 'package:movie_app/model/movie_detail.dart';

@immutable
class MovieDetailsResponse {
  final MovieDetails movieDetail;
  final String error;

  MovieDetailsResponse({
    required this.movieDetail,
    required this.error,
  });

  factory MovieDetailsResponse.fromMap(Map<String, dynamic> map) {
    return MovieDetailsResponse(
      movieDetail: MovieDetails.fromMap(map),
      error: '',
    );
  }

  MovieDetailsResponse.withError(String errorValue)
      : movieDetail = MovieDetails(
            id: null,
            adult: null,
            budget: null,
            genres: null,
            releaseDate: '',
            runtime: null),
        error = errorValue;

  @override
  String toString() =>
      'MovieDetailResponse(movieDetail: $movieDetail, error: $error)';
}
