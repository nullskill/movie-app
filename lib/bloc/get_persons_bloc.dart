import 'package:flutter/foundation.dart';
import 'package:movie_app/model/person_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class PersonsListBloc {
  final _repository = MovieRepository();
  final _subject = BehaviorSubject<PersonResponse>();

  BehaviorSubject<PersonResponse> get subject => _subject;

  Future<void> getPersons() async {
    final response = await _repository.getPersons();
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

final personsBloc = PersonsListBloc();
