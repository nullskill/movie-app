import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/ui/res/colors.dart';
import 'package:movie_app/ui/widgets/genres_showcase.dart';
import 'package:movie_app/ui/widgets/now_playing.dart';
import 'package:movie_app/ui/widgets/top_movies.dart';
import 'package:movie_app/ui/widgets/trending_persons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        brightness: Brightness.dark,
        centerTitle: true,
        leading: Icon(EvaIcons.menu2Outline, color: AppColors.whiteColor),
        title: Text('Movie app'),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.searchOutline,
              color: AppColors.whiteColor,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: ListView(
        children: [
          NowPlaying(),
          GenresShowcase(),
          TrendingPersons(),
          TopMovies(),
        ],
      ),
    );
  }
}
