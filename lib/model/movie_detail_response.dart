import 'package:flutter/foundation.dart';
import 'package:movie_app/model/movie_detail.dart';

@immutable
class CastResponse {
  final MovieDetail movieDetail;
  final String error;

  CastResponse({
    required this.movieDetail,
    required this.error,
  });

  factory CastResponse.fromMap(Map<String, dynamic> map) {
    return CastResponse(
      movieDetail: MovieDetail.fromMap(map),
      error: '',
    );
  }

  CastResponse.withError(String errorValue)
      : movieDetail = MovieDetail(
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
