import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GenresListBloc {
  final _repository = MovieRepository();
  final _subject = BehaviorSubject<GenreResponse>();

  BehaviorSubject<GenreResponse> get subject => _subject;

  Future<void> getGenres() async {
    final response = await _repository.getGenres();
    _subject.add(response);
  }

  void dispose() {
    _subject.close();
  }
}

final genresBloc = GenresListBloc();
