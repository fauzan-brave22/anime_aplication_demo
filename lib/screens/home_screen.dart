import 'package:animelist/screens/anime_screen.dart';
import 'package:animelist/screens/categories_screen.dart';
import 'package:animelist/screens/search_screen.dart';
import 'package:animelist/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.index});

  final int? index;

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
    super.initState();
  }

  bool canPop() {
    if (_selectedIndex == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool onPopInvoked(bool didPop, result) {
    if (!didPop) {
      _selectedIndex = 0;
      setState(() {});
    }
    return true;
  }

  final _destination = const [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
    NavigationDestination(icon: Icon(Icons.category), label: 'Category'),
    NavigationDestination(icon: Icon(Icons.settings), label: 'Setting')
  ];

  final _screens = [
    AnimeScreen(),
    SearchScreen(),
    CategoriesScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: onPopInvoked,
      canPop: canPop(),
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: NavigationBar(
          elevation: 12,
          selectedIndex: _selectedIndex,
          destinations: _destination,
          animationDuration: Duration(milliseconds: 200),
          indicatorColor: const Color.fromARGB(255, 5, 101, 66),
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
