import 'package:animelist/database_helper/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef IsEnglish = bool;

class TitleLanguageCubits extends Cubit<IsEnglish> {
  TitleLanguageCubits() : super(false) {
    _fetchTitleLaguage();
  }

  bool get isEnglish => state;

  Future _fetchTitleLaguage() async {
    final isEnglish = await DatabaseHelper.instance.isEnglish;
    emit(isEnglish);
  }

  Future changeTitleLanguage({required bool isEnglish}) async {
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    emit(isEnglish);
  }
}
