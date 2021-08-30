import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Movie extends Equatable {
  final int id;
  final String title;
  final String? poster;
  final String? backPoster;
  final String overview;
  final num popularity;
  final num rating;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.backPoster,
    required this.overview,
    required this.popularity,
    required this.rating,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? poster,
    String? backPoster,
    String? overview,
    double? popularity,
    double? rating,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
      overview: overview ?? this.overview,
      backPoster: backPoster ?? this.backPoster,
      popularity: popularity ?? this.popularity,
      rating: rating ?? this.rating,
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      poster: map['poster_path'],
      backPoster: map['backdrop_path'],
      overview: map['overview'],
      popularity: map['popularity'],
      rating: map['vote_average'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        poster,
        backPoster,
        overview,
        popularity,
        rating,
      ];

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, poster: $poster, overview: $overview, backPoster: $backPoster, popularity: $popularity, rating: $rating)';
  }
}
