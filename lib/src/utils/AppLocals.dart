import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
class AppLocals {
  static AppLocals? of(BuildContext context) {
    return Localizations.of<AppLocals>(context, AppLocals);
  }

  String getText(String key) => language?[key];
}

Map<String, dynamic>? language;

class AppLocalsDelegate extends LocalizationsDelegate<AppLocals> {
  const AppLocalsDelegate();

  @override
  bool isSupported(Locale locale) => ['en','ar'].contains(locale.languageCode);

  @override
  Future<AppLocals> load(Locale locale) async {
    String string = await rootBundle.loadString("assets/strings/${locale.languageCode}.json");
    language = json.decode(string);
    return SynchronousFuture<AppLocals>(AppLocals());
  }

  @override
  bool shouldReload(AppLocalsDelegate old) => false;
}