import 'dart:convert';

import 'package:animelist/config/config.dart';
import 'package:animelist/models/anime.dart';
import 'package:animelist/models/anime_info.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Anime>> getAnimeBySearch({
  required String query,
}) async {
  final baseUrl = 'https://api.myanimelist.net/v2/anime?q=$query&limit=8';

  final response = await http
      .get(Uri.parse(baseUrl), headers: {'X-MAL-CLIENT-ID': cliendId});

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    AnimeInfo animeInfo = AnimeInfo.fromJson(data);
    Iterable<Anime> animes = animeInfo.animes;
    return animes;
  } else {
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Error: ${response.body}");
    throw Exception("Failed to get data!");
  }
}
