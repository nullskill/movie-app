import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Video extends Equatable {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  Video({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  Video copyWith({
    String? id,
    String? key,
    String? name,
    String? site,
    String? type,
  }) {
    return Video(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      site: site ?? this.site,
      type: type ?? this.type,
    );
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'],
      key: map['key'],
      name: map['name'],
      site: map['site'],
      type: map['type'],
    );
  }

  @override
  List<Object?> get props => [id, key, name, site, type];

  @override
  String toString() {
    return 'Video(id: $id, key: $key, name: $name, site: $site, type: $type)';
  }
}
