import 'package:fixa_renda/ui/theme/type_scheme.dart';
import 'package:flutter/material.dart';

import 'color_schemes.g.dart';

ThemeData getThemeData(BuildContext context, bool isDarkMode) => ThemeData(
    useMaterial3: true,
    cardTheme: CardTheme(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<BeveledRectangleBorder>(
            const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        )),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: Theme.of(context).textTheme.bodyMedium!,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<BeveledRectangleBorder>(
            const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
        )),
      ),
    ),
    colorScheme: isDarkMode ? darkColorScheme : lightColorScheme,
    textTheme: textScheme);
