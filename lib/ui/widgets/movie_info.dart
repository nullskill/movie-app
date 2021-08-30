import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movie_details_bloc.dart';
import 'package:movie_app/model/movie_detail.dart';
import 'package:movie_app/model/movie_detail_response.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/app_error.dart';
import 'package:movie_app/ui/widgets/loader.dart';

class MovieInfo extends StatefulWidget {
  final int id;

  const MovieInfo({Key? key, required this.id}) : super(key: key);

  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();

    movieDetailsBloc..getMovieDetails(widget.id);
  }

  @override
  void dispose() {
    movieDetailsBloc..drainStream();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetailsResponse>(
      stream: movieDetailsBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.error.isNotEmpty) {
            return AppError(error: data.error);
          }
          return _MovieInfo(details: data.movieDetail);
        }
        if (snapshot.hasError) {
          return AppError(error: snapshot.error.toString());
        }

        return Loader();
      },
    );
  }
}

class _MovieInfo extends StatelessWidget {
  static const budgetTitle = 'BUDGET';
  static const durationTitle = 'DURATION';
  static const releasedTitle = 'RELEASE DATE';
  static const genresTitle = 'GENRES';
  final MovieDetails? details;

  const _MovieInfo({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (details == null) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Movie info columns
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoColumn(
                title: budgetTitle,
                value: '${details!.budget} \$',
              ),
              _InfoColumn(
                title: durationTitle,
                value: '${details!.runtime} min',
              ),
              _InfoColumn(
                title: releasedTitle,
                value: details!.releaseDate,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Genres
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                genresTitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.titleColor,
                ),
              ),
              const SizedBox(height: 10),
              _GenreChip(details: details),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.titleColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.secondColor,
          ),
        )
      ],
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({
    Key? key,
    required this.details,
  }) : super(key: key);

  final MovieDetails? details;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: details!.genres.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(
                    width: 1,
                    color: AppColors.whiteColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    details!.genres[index].name,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
