import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_detail_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/utils/consts.dart';

// The movie repository for managing API calls
/// API docs: https://developers.themoviedb.org/3/getting-started/introduction
class MovieRepository {
  final Dio _dio = Dio();

  final getMoviesUrl = '$apiUrl/discover/movie';
  final getPopularUrl = '$apiUrl/movie/top_rated';
  final getPlayingUrl = '$apiUrl/movie/now_playing';
  final getGenresUrl = '$apiUrl/genre/movie/list';
  final getPersonsUrl = '$apiUrl/trending/person/week';
  final movieUrl = '$apiUrl/movie';

  /// Get the top rated movies on TMDB
  Future<MovieResponse> getMovies() async {
    final params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};

    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);

      return MovieResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return MovieResponse.withError('$error');
    }
  }

  /// Get a list of movies in theatres
  Future<MovieResponse> getPlayingMovies() async {
    final params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};

    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);

      return MovieResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return MovieResponse.withError('$error');
    }
  }

  /// Get the list of official genres for movies
  Future<GenreResponse> getGenres() async {
    final params = {'api_key': apiKey, 'language': 'en-US', 'page': 1};

    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);

      return GenreResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return GenreResponse.withError('$error');
    }
  }

  /// Show the trending people
  Future<PersonResponse> getPersons() async {
    final params = {'api_key': apiKey};

    try {
      Response response =
          await _dio.get(getPersonsUrl, queryParameters: params);

      return PersonResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return PersonResponse.withError('$error');
    }
  }

  /// Discover movies by genre [id]
  Future<MovieResponse> getMoviesByGenre(int id) async {
    final params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      'with_genres': id,
    };

    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);

      return MovieResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return MovieResponse.withError('$error');
    }
  }

  Future<MovieDetailsResponse> getMovieDetails(int id) async {
    final params = {'api_key': apiKey, 'language': 'en-US'};

    try {
      Response response =
          await _dio.get('$movieUrl/$id', queryParameters: params);

      return MovieDetailsResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return MovieDetailsResponse.withError('$error');
    }
  }

  Future<CastResponse> getCasts(int id) async {
    final params = {'api_key': apiKey, 'language': 'en-US'};

    try {
      Response response =
          await _dio.get('$movieUrl/$id/credits', queryParameters: params);

      return CastResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return CastResponse.withError('$error');
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    final params = {'api_key': apiKey, 'language': 'en-US'};

    try {
      Response response =
          await _dio.get('$movieUrl/$id/similar', queryParameters: params);

      return MovieResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return MovieResponse.withError('$error');
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    final params = {'api_key': apiKey, 'language': 'en-US'};

    try {
      Response response =
          await _dio.get('$movieUrl/$id/videos', queryParameters: params);

      return VideoResponse.fromMap(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occured: $error stackTrace: $stackTrace');

      return VideoResponse.withError('$error');
    }
  }
}
