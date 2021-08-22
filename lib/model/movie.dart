import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Movie extends Equatable {
  final int id;
  final String title;
  final String poster;
  final String backPoster;
  final double popularity;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.backPoster,
    required this.popularity,
    required this.rating,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? poster,
    String? backPoster,
    double? popularity,
    double? rating,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      poster: poster ?? this.poster,
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
        popularity,
        rating,
      ];

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, poster: $poster, backPoster: $backPoster, popularity: $popularity, rating: $rating)';
  }
}
