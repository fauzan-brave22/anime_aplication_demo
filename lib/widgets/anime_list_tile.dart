import 'package:animelist/models/anime.dart';
import 'package:animelist/screens/anime_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeListTile extends StatelessWidget {
  const AnimeListTile({super.key, required this.anime, this.rank});

  final Anime anime;
  final int? rank;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AnimeDetailScreen(id: anime.node.id)));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Picture
              SizedBox(
                height: 100,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: anime.node.mainPicture.medium,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(
                width: 20,
              ),

              // Anime info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    rank != null ? AnimesRank(rank: rank!) : SizedBox.shrink(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      anime.node.title,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimesRank extends StatelessWidget {
  const AnimesRank({super.key, required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.amber,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        child: Text(
          'Rank $rank',
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
