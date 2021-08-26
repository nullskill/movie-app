import 'package:movie_app/model/movie_detail.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;
  final String error;

  MovieDetailResponse({
    required this.movieDetail,
    required this.error,
  });

  factory MovieDetailResponse.fromMap(Map<String, dynamic> map) {
    return MovieDetailResponse(
      movieDetail: MovieDetail.fromMap(map['movieDetail']),
      error: '',
    );
  }

  MovieDetailResponse.withError(String errorValue)
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
