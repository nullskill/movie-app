import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesListBloc {
  final _repository = MovieRepository();
  final _subject = BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  Future<void> getMovies() async {
    final response = await _repository.getMovies();
    _subject.add(response);
  }

  void dispose() {
    _subject.close();
  }
}

final moviesBloc = MoviesListBloc();
