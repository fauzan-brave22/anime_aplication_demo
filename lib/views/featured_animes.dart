import 'package:animelist/api/get_anime_by_rangking.dart';
import 'package:animelist/screens/anime_detail_screen.dart';
import 'package:animelist/screens/view_all_screen.dart';
import 'package:animelist/utils/error_screen.dart';
import 'package:animelist/utils/loader.dart';
import 'package:animelist/widgets/anime_tile.dart';
import 'package:flutter/material.dart';

class FeaturedAnimes extends StatelessWidget {
  const FeaturedAnimes(
      {super.key, required this.rankingType, required this.label});

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnimeByRangkingType(rankingType: rankingType, limit: 10),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }

          if (snapshot.data != null) {
            final animes = snapshot.data;
            return Column(
              children: [
                // Title Part
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ViewAllScreen(
                                    rankingType: rankingType, label: label)));
                          },
                          child: Text('View All'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: animes!.length,
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
                                builder: (_) =>
                                    AnimeDetailScreen(id: anime.node.id)));
                          },
                          child: AnimeTile(anime: anime.node));
                    },
                  ),
                )
              ],
            );
          }

          return ErrorScreen(error: snapshot.error.toString());
        });
  }
}
