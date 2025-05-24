import 'package:animelist/api/get_anime_by_rangking.dart';
import 'package:animelist/models/anime_category.dart';
import 'package:animelist/utils/error_screen.dart';
import 'package:animelist/utils/loader.dart';
import 'package:animelist/views/anime_grid_list.dart';
import 'package:flutter/material.dart';

class AnimeGridView extends StatelessWidget {
  const AnimeGridView({super.key, required this.category});

  final AnimeCategory category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnimeByRangkingType(
            rankingType: category.rankingType, limit: 100),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }

          if (snapshot.data != null) {
            final animes = snapshot.data;

            return AnimeGridList(
              title: category.title,
              animes: animes!,
            );
          }
          return ErrorScreen(error: snapshot.error.toString());
        });
  }
}
