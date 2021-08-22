import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesListByGenreBloc {
  final _repository = MovieRepository();
  final _subject = BehaviorSubject<MovieResponse?>();

  BehaviorSubject<MovieResponse?> get subject => _subject;

  Future<void> getMoviesByGenre(int id) async {
    final response = await _repository.getMoviesByGenre(id);
    _subject.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final moviesByGenreBloc = MoviesListByGenreBloc();
