import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movie_details_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie_detail_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();

    movieDetailsBloc..getMovieDetails(widget.movie.id);
  }

  @override
  void dispose() {
    movieDetailsBloc..drainStream();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Builder(
        builder: (context) {
          return SliverFab(
              slivers: [],
              floatingPosition: FloatingPosition(right: 20),
              floatingWidget: StreamBuilder<MovieDetailsResponse>(
                stream: movieDetailsBloc.subject.stream,
                builder: (context, snapshot) {
                  return SizedBox();
                },
              ));
        },
      ),
    );
  }
}
