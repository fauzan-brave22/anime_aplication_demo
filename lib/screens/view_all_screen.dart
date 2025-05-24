import 'package:animelist/api/get_anime_by_rangking.dart';
import 'package:animelist/utils/error_screen.dart';
import 'package:animelist/utils/loader.dart';
import 'package:animelist/views/anime_list_view.dart';
import 'package:flutter/material.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen(
      {super.key, required this.rankingType, required this.label});

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
        ),
      ),
      body: FutureBuilder(
          future: getAnimeByRangkingType(rankingType: rankingType, limit: 500),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }

            if (snapshot.data != null) {
              return AnimeListView(animes: snapshot.data!);
            }

            return ErrorScreen(error: snapshot.error.toString());
          }),
    );
  }
}
