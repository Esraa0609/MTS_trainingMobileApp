import 'package:flutter/material.dart';

class LocaleModel extends ChangeNotifier {
  Locale? _locale;
  int _indx = 1;

  Locale? get locale => _locale;
  int? getindx() => _indx;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void setIndx(int indx) {
    _indx = indx;
  }
}