import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, TURKISH }

const String TURKISH = "tr";
const String ENGLISH = "en";
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";
const Locale TURKISH_LOCAL = Locale("tr","TR");
const Locale ENGLISH_LOCAL = Locale("en","US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.TURKISH:
        return TURKISH;
    }
  }
}
