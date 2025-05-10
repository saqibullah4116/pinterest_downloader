import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getLocalizedThemeName(BuildContext context, String themeName) {
  final loc = AppLocalizations.of(context)!;

  switch (themeName) {
    case 'Pinterest':
      return loc.pinterest;
    case 'Light':
      return loc.light;
    case 'Dark':
      return loc.dark;
    case 'Midnight Blue':
      return loc.midnightBlue;
    case 'Nature':
      return loc.nature;
    case 'Sunset':
      return loc.sunset;
    case 'Purple Haze':
      return loc.purpleHaze;
    default:
      return themeName;
  }
}
