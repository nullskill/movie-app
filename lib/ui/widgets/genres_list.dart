import 'package:flutter/material.dart';
import 'package:movie_app/bloc/get_movies_by_genre_bloc.dart';
import 'package:movie_app/model/genre.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/genre_movies.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;

  const GenresList({Key? key, required this.genres}) : super(key: key);

  @override
  _GenresListState createState() => _GenresListState();
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: widget.genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307,
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: AppColors.mainColor,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.secondColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              unselectedLabelColor: AppColors.titleColor,
              labelColor: AppColors.whiteColor,
              isScrollable: true,
              tabs: widget.genres.map((g) {
                return Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    g.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: widget.genres.map((g) {
            return GenreMovies(genreId: g.id);
          }).toList(),
        ),
      ),
    );
  }
}
