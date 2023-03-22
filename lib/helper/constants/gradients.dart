import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/helper/constants/colors.dart';

class AppGradient {
  AppGradient._internal();

  factory AppGradient() {
    return _appGradient;
  }

  LinearGradient green() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#40D753')),
        Color(appColors.getColorHexFromStr('#31B042')),
      ],
    );
  }

  LinearGradient grey() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#999999')),
        Color(appColors.getColorHexFromStr('#999999')),
      ],
    );
  }

  LinearGradient greyLight() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#EDEDED')),
        Color(appColors.getColorHexFromStr('#EDEDED')),
      ],
    );
  }

  LinearGradient greyBtn() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#555555')),
        Color(appColors.getColorHexFromStr('#555555')),
      ],
    );
  }

  LinearGradient blue() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#0078D4')),
        Color(appColors.getColorHexFromStr('#00A9E9')),
      ],
    );
  }

  LinearGradient blueHeader() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#31D1EA')),
        Color(appColors.getColorHexFromStr('#2E78AA')),
      ],
    );
  }

  LinearGradient purple() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#A060FF')),
        Color(appColors.getColorHexFromStr('#1F7BA8')),
      ],
    );
  }

  LinearGradient brownNew() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#FF2B55')),
        Color(appColors.getColorHexFromStr('#B02C2C')),
      ],
    );
  }

  LinearGradient yellow() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#EBCF06')),
        Color(appColors.getColorHexFromStr('#F7881A')),
      ],
    );
  }

  LinearGradient white() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#FFFFFF')),
        Color(appColors.getColorHexFromStr('#FFFFFF')),
      ],
    );
  }

  LinearGradient red() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#FD5757')),
        Color(appColors.getColorHexFromStr('#D82F2F')),
      ],
    );
  }

  LinearGradient redCard() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#FF2B55')),
        Color(appColors.getColorHexFromStr('#B02C2C')),
      ],
    );
  }

  LinearGradient navyBlue() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#00A9E9')),
        Color(appColors.getColorHexFromStr('#0083B5')),
      ],
    );
  }

  LinearGradient orange() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: const [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#EBCF06')),
        Color(appColors.getColorHexFromStr('#F7881A')),
      ],
    );
  }

  LinearGradient greenAppBar() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.0, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#00ECF2')),
        Color(appColors.getColorHexFromStr('#3FD452')),
      ],
    );
  }

  LinearGradient greenButton() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.0, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#31B042')),
        Color(appColors.getColorHexFromStr('#40D753')),
      ],
    );
  }

  LinearGradient greenSky() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.0, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#3FD452')),
        Color(appColors.getColorHexFromStr('#00ECF2')),
      ],
    );
  }

  LinearGradient brown() {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: const [0.2, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(appColors.getColorHexFromStr('#E9C225')),
        Color(appColors.getColorHexFromStr('#BE5200')),
      ],
    );
  }

  static final AppGradient _appGradient = AppGradient._internal();
}

AppGradient appGradient = AppGradient();
