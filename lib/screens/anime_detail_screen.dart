import 'package:animelist/api/get_anime_by_details.dart';
import 'package:animelist/cubits/title_language_cubits.dart';
import 'package:animelist/models/anime_details.dart';
import 'package:animelist/models/picture.dart';
import 'package:animelist/screens/setting_screen.dart';
import 'package:animelist/utils/error_screen.dart';
import 'package:animelist/utils/ios_back_button.dart';
import 'package:animelist/utils/loader.dart';
import 'package:animelist/utils/network_image_view.dart';
import 'package:animelist/utils/read_more_text.dart';
import 'package:animelist/views/recomendation_anime.dart';
import 'package:animelist/widgets/info_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeDetailScreen extends StatelessWidget {
  const AnimeDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnimeByDetails(id: id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }

          if (snapshot.data != null) {
            final anime = snapshot.data;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Image
                    _buildAnimeImage(imageUrl: anime!.mainPicture.large),

                    // Title Anime
                    Padding(
                      padding:
                          EdgeInsets.only(left: 24.0, right: 24.0, top: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAnimeTitle(
                              name: anime.title,
                              englishName: anime.alternativeTitles.en),

                          SizedBox(
                            height: 20,
                          ),

                          // Description
                          ReadMoreText(longText: anime.synopsis),

                          SizedBox(
                            height: 10,
                          ),

                          // Anime Info
                          _buildAnimeInfo(anime: anime),

                          SizedBox(
                            height: 10,
                          ),

                          // Anime Background
                          anime.background.isNotEmpty
                              ? _buildAnimeBackground(
                                  background: anime.background)
                              : SizedBox.shrink(),

                          _buildImageGallery(images: anime.pictures),

                          SizedBox(
                            height: 20,
                          ),

                          RecomendationAnime(
                              animes: anime.relatedAnime
                                  .map((relatedAnimes) => relatedAnimes.node)
                                  .toList(),
                              label: 'Related Animes'),

                          anime.recommendations.isNotEmpty
                              ? RecomendationAnime(
                                  animes: anime.recommendations
                                      .map((animeRec) => animeRec.node)
                                      .toList(),
                                  label: 'Recomendation')
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return ErrorScreen(error: snapshot.error.toString());
        });
  }

  _buildAnimeImage({required String imageUrl}) => Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 400,
            width: double.infinity,
          ),
          Positioned(
            top: 30,
            left: 20,
            child: Builder(builder: (contex) {
              return IosBackButton(onPressed: Navigator.of(contex).pop);
            }),
          )
        ],
      );

  Widget _buildAnimeTitle(
          {required String name, required String englishName}) =>
      BlocBuilder<TitleLanguageCubits, bool>(builder: (context, state) {
        return Text(
          englishName,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        );
      });

  Widget _buildAnimeInfo({required AnimeDetails anime}) {
    String studios = anime.studios.map((studio) => studio.name).join(', ');
    String genres = anime.genres.map((genre) => genre.name).join(', ');
    String otheNames =
        anime.alternativeTitles.synonyms.map((title) => title).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(label: 'Genres: ', info: genres),
        InfoText(label: 'Start date: ', info: anime.startDate),
        InfoText(label: 'End date: ', info: anime.endDate),
        InfoText(label: 'Episode: ', info: anime.numEpisodes.toString()),
        InfoText(
            label: 'Avarage Episode Duration: ',
            info: anime.averageEpisodeDuration.toString()),
        InfoText(label: 'Status: ', info: anime.status),
        InfoText(label: 'Rating: ', info: anime.rating),
        InfoText(label: 'Studio: ', info: studios),
        InfoText(label: 'Other Name: ', info: otheNames),
        InfoText(label: 'English Name: ', info: anime.alternativeTitles.en),
        InfoText(label: 'Japanese Name: ', info: anime.alternativeTitles.ja),
      ],
    );
  }

  Widget _buildAnimeBackground({required String background}) {
    return WhiteContainer(
        child: Text(
      background,
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
    ));
  }

  Widget _buildImageGallery({required List<Picture> images}) {
    return Column(
      children: [
        Text(
          'Image Gallery',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        GridView.builder(
            itemCount: images.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 9 / 16),
            itemBuilder: (context, index) {
              final image = images[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            NetworkImageView(imageUrl: image.large)));
                  },
                  child: Image.network(
                    image.medium,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            })
      ],
    );
  }
}

class WhiteContainer extends StatelessWidget {
  const WhiteContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.white54,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
