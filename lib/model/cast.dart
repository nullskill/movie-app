import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Cast extends Equatable {
  final int id;
  final String character;
  final String name;
  final String? img;

  Cast({
    required this.id,
    required this.character,
    required this.name,
    required this.img,
  });

  Cast copyWith({
    int? id,
    String? character,
    String? name,
    String? img,
  }) {
    return Cast(
      id: id ?? this.id,
      character: character ?? this.character,
      name: name ?? this.name,
      img: img ?? this.img,
    );
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      id: map['id'],
      character: map['character'],
      name: map['name'],
      img: map['profile_path'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        character,
        name,
        img,
      ];

  @override
  String toString() {
    return 'Cast(id: $id, character: $character, name: $name, img: $img)';
  }
}
