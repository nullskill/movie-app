import 'package:flutter/foundation.dart';
import 'package:movie_app/model/video_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieVideosBloc {
  final MovieRepository _repository = MovieRepository();
  final _subject = BehaviorSubject<VideoResponse>();

  BehaviorSubject<VideoResponse> get subject => _subject;

  Future<void> getMovieVideos(int id) async {
    final response = await _repository.getMovieVideos(id);
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

final movieVideosBloc = MovieVideosBloc();
