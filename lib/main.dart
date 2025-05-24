import 'package:animelist/config/theme/app_theme.dart';
import 'package:animelist/cubits/theme_cubits.dart';
import 'package:animelist/cubits/title_language_cubits.dart';
import 'package:animelist/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubits()),
        BlocProvider(create: (context) => TitleLanguageCubits())
      ],
      child: BlocBuilder<ThemeCubits, ThemeMode>(builder: (context, state) {
        final themeMode = state;
        return MaterialApp(
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      }),
    );
  }
}
