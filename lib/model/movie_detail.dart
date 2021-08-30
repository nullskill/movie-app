import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/model/genre.dart';

@immutable
class MovieDetails extends Equatable {
  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final String releaseDate;
  final int? runtime;

  MovieDetails({
    required this.id,
    required this.adult,
    required this.budget,
    required this.genres,
    required this.releaseDate,
    required this.runtime,
  });

  MovieDetails copyWith({
    int? id,
    bool? adult,
    int? budget,
    List<Genre>? genres,
    String? releaseDate,
    int? runtime,
  }) {
    return MovieDetails(
      id: id ?? this.id,
      adult: adult ?? this.adult,
      budget: budget ?? this.budget,
      genres: genres ?? this.genres,
      releaseDate: releaseDate ?? this.releaseDate,
      runtime: runtime ?? this.runtime,
    );
  }

  factory MovieDetails.fromMap(Map<String, dynamic> map) {
    return MovieDetails(
      id: map['id'],
      adult: map['adult'],
      budget: map['budget'],
      genres: List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x))),
      releaseDate: map['release_date'],
      runtime: map['runtime'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        adult,
        budget,
        genres,
        releaseDate,
        runtime,
      ];

  @override
  String toString() {
    return 'MovieDetail(id: $id, adult: $adult, budget: $budget, genres: $genres, releaseDate: $releaseDate, runtime: $runtime)';
  }
}
