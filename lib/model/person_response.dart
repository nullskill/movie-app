import 'package:meta/meta.dart';
import 'package:movie_app/model/person.dart';

@immutable
class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse({
    required this.persons,
    required this.error,
  });

  factory PersonResponse.fromMap(Map<String, dynamic> map) {
    return PersonResponse(
      persons: List<Person>.from(map['results']?.map((m) => Person.fromMap(m))),
      error: '',
    );
  }

  PersonResponse.withError(String errorValue)
      : persons = [],
        error = errorValue;

  @override
  String toString() => 'PersonResponse(movies: $persons, error: $error)';
}
