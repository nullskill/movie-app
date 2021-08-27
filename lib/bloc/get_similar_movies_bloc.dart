import 'package:flutter/foundation.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class SimilarMoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final _subject = BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  Future<void> getSimilarMovies(int id) async {
    final response = await _repository.getSimilarMovies(id);
    _subject.add(response);
  }

  Future<void> drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  Future<void> dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final similarMoviesBloc = SimilarMoviesBloc();
