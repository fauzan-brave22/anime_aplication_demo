import 'package:animelist/api/get_anime_by_searc.dart';
import 'package:animelist/models/anime.dart';
import 'package:animelist/models/anime_node.dart';
import 'package:animelist/widgets/anime_list_tile.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Search for Animes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showSearch(context: context, delegate: AnimeSerchDeligate());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 70,
                  color: Colors.grey,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 20, 10),
                      child: Text(
                        'Search',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimeSerchDeligate extends SearchDelegate<List<AnimeNode>> {
  Iterable<Anime> anime = [];

  Future searchAnime(String query) async {
    final animes = await getAnimeBySearch(query: query);

    anime = animes.toList();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResult(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchAnime(query);
    return _buildSearchResult(context);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, []);
        });
  }

  Widget _buildSearchResult(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Enter search query'),
      );
    } else {
      return FutureBuilder<Iterable<Anime>>(
          future: getAnimeBySearch(query: query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final animes = snapshot.data ?? [];
              return SearchResultView(animes: animes);
            }
          });
    }
  }
}

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key, required this.animes});

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 36.0),
      child: ListView.builder(
          itemCount: animes.length,
          itemBuilder: (context, index) {
            final anime = animes.elementAt(index);

            return AnimeListTile(anime: anime);
          }),
    );
  }
}
