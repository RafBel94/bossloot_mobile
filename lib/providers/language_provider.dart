import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('es');

  Locale get locale => _locale;

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      _locale = Locale(languageCode);
    } else {
      _locale = const Locale('es');
    }
    notifyListeners();
  }

  void setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_locale != locale) {
      _locale = locale;
      await prefs.setString('languageCode', locale.languageCode);
      notifyListeners();
    }
  }

  void clearLocale() {
    _locale = const Locale('es');
    notifyListeners();
  }
}