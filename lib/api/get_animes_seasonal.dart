import 'dart:convert';

import 'package:animelist/config/config.dart';
import 'package:animelist/models/anime.dart';
import 'package:animelist/models/anime_info.dart';
import 'package:animelist/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Anime>> getAnimeBySeasonalAnime({
  required int limit,
}) async {
  final year = DateTime.now().year;
  final season = getCurrentSeason();
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/season/$year/$season?limit=$limit';

  final response = await http
      .get(Uri.parse(baseUrl), headers: {'X-MAL-CLIENT-ID': cliendId});

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final seasonAnime = AnimeInfo.fromJson(data);

    return seasonAnime.animes;
  } else {
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Error: ${response.body}");
    throw Exception("Failed to get data!");
  }
}
