import 'package:animelist/cubits/theme_cubits.dart';
import 'package:animelist/cubits/title_language_cubits.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitchWidget(),
            SizedBox(
              height: 20,
            ),
            TitleLanguageSwitchState(),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool isDarkMode = false;

  Future<void> toggleDarkMode(value) async {
    setState(() => isDarkMode = !isDarkMode);
    context.read<ThemeCubits>().changeTheme(isDarkMode: isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Is Dark Mode'),
        BlocBuilder<ThemeCubits, ThemeMode>(builder: (context, state) {
          isDarkMode = state == ThemeMode.dark;
          return CupertinoSwitch(value: isDarkMode, onChanged: toggleDarkMode);
        }),
      ],
    );
  }
}

class TitleLanguageSwitchState extends StatefulWidget {
  const TitleLanguageSwitchState({super.key});

  @override
  State<TitleLanguageSwitchState> createState() =>
      _TitleLanguageSwitchStateState();
}

class _TitleLanguageSwitchStateState extends State<TitleLanguageSwitchState> {
  bool isEnglish = false;

  Future<void> toggleTitleLanguage(_) async {
    setState(() => isEnglish = !isEnglish);
    context
        .read<TitleLanguageCubits>()
        .changeTitleLanguage(isEnglish: isEnglish);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Is Dark Mode'),
        BlocBuilder<TitleLanguageCubits, bool>(builder: (context, state) {
          isEnglish = state;
          return CupertinoSwitch(
              value: isEnglish, onChanged: toggleTitleLanguage);
        }),
      ],
    );
  }
}
