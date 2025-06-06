import 'package:animelist/models/anime.dart';
import 'package:animelist/screens/anime_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AnimeGridList extends StatelessWidget {
  const AnimeGridList({super.key, required this.title, required this.animes});

  final String title;
  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: animes.length,
      itemBuilder: (context, index) {
        final anime = animes.elementAt(index);

        return AnimeGridTile(anime: anime);
      },
    );
  }
}

class AnimeGridTile extends StatelessWidget {
  const AnimeGridTile({super.key, required this.anime});

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AnimeDetailScreen(id: anime.node.id)));
      },
      child: Material(
        elevation: 5,
        child: CachedNetworkImage(
          imageUrl: anime.node.mainPicture.medium,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
