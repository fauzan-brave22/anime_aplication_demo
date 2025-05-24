import 'dart:convert';

import 'package:animelist/config/config.dart';
import 'package:animelist/models/anime.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<Iterable<Anime>> getAnimeByRangkingType(
    {required String rankingType, required int limit}) async {
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit';

  final response = await http
      .get(Uri.parse(baseUrl), headers: {'X-MAL-CLIENT-ID': cliendId});

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> animeNodeList = data['data'];
    final animes = animeNodeList
        .where((animeNode) => animeNode['node']['main_picture'] != null)
        .map((node) => Anime.fromJson(node));

    return animes;
  } else {
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Error: ${response.body}");
    throw Exception("Failed to get data!");
  }
}
