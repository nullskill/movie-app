import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Person extends Equatable {
  final int id;
  final String name;
  final num popularity;
  final String? profileImg;
  final String known;

  Person({
    required this.id,
    required this.name,
    required this.popularity,
    required this.profileImg,
    required this.known,
  });

  Person copyWith({
    int? id,
    String? name,
    double? popularity,
    String? profileImg,
    String? known,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      popularity: popularity ?? this.popularity,
      profileImg: profileImg ?? this.profileImg,
      known: known ?? this.known,
    );
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
      popularity: map['popularity'],
      profileImg: map['profile_path'],
      known: map['known_for_department'],
    );
  }

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        name,
        popularity,
        profileImg,
        known,
      ];

  @override
  String toString() {
    return 'Person(id: $id, name: $name, popularity: $popularity, profileImg: $profileImg, known: $known)';
  }
}
