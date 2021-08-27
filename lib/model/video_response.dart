import 'package:meta/meta.dart';
import 'package:movie_app/model/video.dart';

@immutable
class VideoResponse {
  final List<Video> videos;
  final String error;

  VideoResponse({
    required this.videos,
    required this.error,
  });

  factory VideoResponse.fromMap(Map<String, dynamic> map) {
    return VideoResponse(
      videos: List<Video>.from(map['results']?.map((m) => Video.fromMap(m))),
      error: '',
    );
  }

  VideoResponse.withError(String errorValue)
      : videos = [],
        error = errorValue;

  @override
  String toString() => 'VideoResponse(videos: $videos, error: $error)';
}
