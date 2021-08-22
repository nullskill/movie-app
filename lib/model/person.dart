import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Person extends Equatable {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;

  Person({
    required this.id,
    required this.popularity,
    required this.name,
    required this.profileImg,
    required this.known,
  });

  Person copyWith({
    int? id,
    double? popularity,
    String? name,
    String? profileImg,
    String? known,
  }) {
    return Person(
      id: id ?? this.id,
      popularity: popularity ?? this.popularity,
      name: name ?? this.name,
      profileImg: profileImg ?? this.profileImg,
      known: known ?? this.known,
    );
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      popularity: map['popularity'],
      name: map['name'],
      profileImg: map['profile_path'],
      known: map['known_for_department'],
    );
  }

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        popularity,
        name,
        profileImg,
        known,
      ];

  @override
  String toString() {
    return 'Person(id: $id, popularity: $popularity, name: $name, profileImg: $profileImg, known: $known)';
  }
}
