import 'package:animelist/models/anime.dart';
import 'package:animelist/screens/anime_detail_screen.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TopAnimeImagesSlider extends StatefulWidget {
  const TopAnimeImagesSlider({super.key, required this.animes});

  final Iterable<Anime> animes;

  @override
  State<TopAnimeImagesSlider> createState() => _TopAnimeImagesSliderState();
}

class _TopAnimeImagesSliderState extends State<TopAnimeImagesSlider> {
  int _currentPage = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.animes.length,
              itemBuilder: (context, index, realIndex) {
                final anime = widget.animes.elementAt(index);
                return TopAnimePicture(anime: anime);
              },
              options: CarouselOptions(
                  enlargeFactor: 0.22,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.88,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  initialPage: _currentPage)),
          const SizedBox(
            height: 30,
          ),
          AnimatedSmoothIndicator(
            activeIndex: _currentPage,
            count: widget.animes.length,
            effect: CustomizableEffect(
                dotDecoration: DotDecoration(
                    rotationAngle: 180,
                    borderRadius: BorderRadius.circular(8.0),
                    width: 28.0,
                    height: 8.0,
                    color: Theme.of(context).primaryColor),
                activeDotDecoration: DotDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue,
                    width: 28.0,
                    height: 8.0)),
          )
        ],
      ),
    );
  }
}

class TopAnimePicture extends StatelessWidget {
  const TopAnimePicture({super.key, required this.anime});

  final Anime anime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AnimeDetailScreen(id: anime.node.id)));
      },
      splashColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            anime.node.mainPicture.medium,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
