import 'package:flutter/foundation.dart';
import 'package:movie_app/model/movie_detail_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieDetailsBloc {
  final MovieRepository _repository = MovieRepository();
  final _subject = BehaviorSubject<MovieDetailsResponse>();

  BehaviorSubject<MovieDetailsResponse> get subject => _subject;

  Future<void> getMovieDetails(int id) async {
    final response = await _repository.getMovieDetails(id);
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

final movieDetailsBloc = MovieDetailsBloc();
