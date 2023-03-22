import 'package:flutter/material.dart';
import 'package:web/helper/constants/colors.dart';

enum MyThemeKeys { LIGHT, DARK }

class MyThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Color(appColors.aquaGreen),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    backgroundColor: Colors.black54,
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Colors.grey),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
