import 'package:animelist/models/anime_category.dart';
import 'package:animelist/views/anime_grid_view.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _animeTabs = animeCategories
      .map((animeCategory) => Tab(
            text: animeCategory.title,
          ))
      .toList();

  final _screens = animeCategories
      .map((animeCategoriy) => AnimeGridView(category: animeCategoriy))
      .toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Anime Categories'),
          bottom: TabBar(
            tabs: _animeTabs,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorWeight: 3,
            labelColor: const Color.fromARGB(255, 5, 101, 66),
            indicatorColor: const Color.fromARGB(255, 5, 101, 66),
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        body: TabBarView(children: _screens),
      ),
    );
  }
}
