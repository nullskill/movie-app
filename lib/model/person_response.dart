import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/model/person.dart';

@immutable
class PersonResponse extends Equatable {
  final List<Person> persons;
  final String error;
  PersonResponse({
    required this.persons,
    required this.error,
  });

  PersonResponse copyWith({
    List<Person>? persons,
    String? error,
  }) {
    return PersonResponse(
      persons: persons ?? this.persons,
      error: error ?? this.error,
    );
  }

  factory PersonResponse.fromMap(Map<String, dynamic> map) {
    return PersonResponse(
      persons: List<Person>.from(map['results']?.map((m) => Person.fromMap(m))),
      error: '',
    );
  }

  PersonResponse.withError(String errorValue)
      : persons = List.empty(),
        error = errorValue;

  @override
  List<Object?> get props => [persons, error];

  @override
  String toString() => 'PersonResponse(movies: $persons, error: $error)';
}
