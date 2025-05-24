import 'package:animelist/screens/home_screen.dart';
import 'package:animelist/views/featured_animes.dart';
import 'package:animelist/widgets/top_anime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AnimeList'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    HomeScreen.routeName,
                    arguments: 1,
                  );
                },
                icon: const Icon(CupertinoIcons.search))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Featured Animes 4
                SizedBox(
                  height: 300,
                  child: TopAnime(),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 36.0),
                  child: Column(
                    children: [
                      // Top Animes
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'all', label: 'Top Anime'),
                      ),
                      // Top Movies
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'movie', label: 'Top Movies'),
                      ),
                      // Top Favorited
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'favorite', label: 'Top Favorited'),
                      ),
                      // Top Popular
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'bypopularity', label: 'Top Popular'),
                      ),
                      // Top Upcoming
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'upcoming', label: 'Top Upcoming'),
                      ),
                      // Top Tv series
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'tv', label: 'Top TV Series'),
                      ),
                      // Top Ova
                      SizedBox(
                        height: 350,
                        child: FeaturedAnimes(
                            rankingType: 'ova', label: 'Top OVA'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
