import 'package:animelist/models/anime.dart';
import 'package:animelist/widgets/anime_list_tile.dart';
import 'package:flutter/material.dart';

class AnimeListView extends StatelessWidget {
  const AnimeListView({super.key, required this.animes});

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
      child: ListView.builder(
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes.elementAt(index);
          return AnimeListTile(anime: anime);
        },
      ),
    );
  }
}
