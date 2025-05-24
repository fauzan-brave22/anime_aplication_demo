import 'package:animelist/api/get_anime_by_rangking.dart';
import 'package:animelist/utils/error_screen.dart';
import 'package:animelist/utils/loader.dart';
import 'package:animelist/widgets/top_anime_images_sllider.dart';
import 'package:flutter/material.dart';

class TopAnime extends StatelessWidget {
  const TopAnime({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeByRangkingType(rankingType: 'all', limit: 4),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final animes = snapshot.data!.toList();
          return TopAnimeImagesSlider(animes: animes);
        }

        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}
