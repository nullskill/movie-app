import 'package:movie_app/model/movie_response.dart';
import 'package:movie_app/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class NowPlayingListBloc {
  final _repository = MovieRepository();
  final _subject = BehaviorSubject<MovieResponse>();

  BehaviorSubject<MovieResponse> get subject => _subject;

  Future<void> getPlayingMovies() async {
    final response = await _repository.getPlayingMovies();
    _subject.add(response);
  }

  void dispose() {
    _subject.close();
  }
}

final nowPlayingMoviesBloc = NowPlayingListBloc();
