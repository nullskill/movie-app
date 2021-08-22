import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/model/person_response.dart';

class MovieRepository {
  final String apiKey = 'c864b6743a99083fc1c2e4accff52c10';
  static String apiUrl = 'https://api.themoviedb.org/3';

  final Dio _dio = Dio();

  final getMoviesUrl = '$apiUrl/discover/movie';
  final getPopularUrl = '$apiUrl/movie/top_rated';
  final getPlayingUrl = '$apiUrl/movie/now_playing';
  final getGenresUrl = '$apiUrl/genre/movie/list';
  final getPersonsUrl = '$apiUrl/trending/person/week';

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
}
