import 'package:flutter/foundation.dart';
import 'package:movie_app/model/cast_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class CastListBloc {
  final MovieRepository _repository = MovieRepository();
  final _subject = BehaviorSubject<CastResponse>();

  BehaviorSubject<CastResponse> get subject => _subject;

  Future<void> getCasts(int id) async {
    final response = await _repository.getCasts(id);
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

final castsBloc = CastListBloc();
