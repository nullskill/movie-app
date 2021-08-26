import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_genres_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/model/genre_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/genres_list.dart';
import 'package:movie_app/ui/widgets/loader.dart';

class Genres extends StatefulWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    super.initState();

    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBloc.subject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.error.isNotEmpty) {
            return AppError(error: data.error);
          }
          return _Genres(genres: data.genres);
        }
        if (snapshot.hasError) {
          return AppError(error: snapshot.error.toString());
        }

        return Loader();
      },
    );
  }
}

class _Genres extends StatelessWidget {
  final List<Genre> genres;

  const _Genres({Key? key, required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return Center(
        child: const Text(
          'No genres',
          style: TextStyle(color: AppColors.blackColor),
        ),
      );
    }

    return GenresList(genres: genres);
  }
}