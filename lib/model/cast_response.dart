import 'package:flutter/foundation.dart';
import 'package:movie_app/model/cast.dart';

@immutable
class CastResponse {
  final List<Cast> casts;
  final String error;

  CastResponse({
    required this.casts,
    required this.error,
  });

  factory CastResponse.fromMap(Map<String, dynamic> map) {
    return CastResponse(
      casts: List<Cast>.from(map['casts']?.map((m) => Cast.fromMap(m))),
      error: '',
    );
  }

  CastResponse.withError(String errorValue)
      : casts = [],
        error = errorValue;

  @override
  String toString() => 'CastResponse(casts: $casts, error: $error)';
}
