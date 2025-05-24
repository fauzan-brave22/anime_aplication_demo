import 'package:animelist/models/anime_node.dart';
import 'package:animelist/screens/anime_detail_screen.dart';
import 'package:animelist/widgets/anime_tile.dart';
import 'package:flutter/material.dart';

class RecomendationAnime extends StatelessWidget {
  const RecomendationAnime(
      {super.key, required this.animes, required this.label});

  final List<AnimeNode> animes;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Part
        SizedBox(
          height: 50,
          child: Text(
            label,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: animes.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              final anime = animes.elementAt(index);
              return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AnimeDetailScreen(id: anime.id)));
                  },
                  child: AnimeTile(anime: anime));
            },
          ),
        )
      ],
    );
  }
}
