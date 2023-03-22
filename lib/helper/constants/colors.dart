class AppColors {
  AppColors._internal();

  factory AppColors() {
    return _appColors;
  }

  get orangeF7941E => getColorHexFromStr('#F7941E');
  get blue002060 => getColorHexFromStr('#002060');
  get blackA312A2A => getColorHexFromStr('#70312A2A');
  get black000000 => getColorHexFromStr('#000000');
  get brown840000 => getColorHexFromStr('#840000');
  get grey312A2AB3 => getColorHexFromStr('#312A2AB3');
  get grey00000029 => getColorHexFromStr('#00000029');
  get greyA5A5A5 => getColorHexFromStr('#A5A5A5');
  get grey7A7A7A => getColorHexFromStr('#7A7A7A');
  get grey5C5C5C => getColorHexFromStr('#5C5C5C');
  get greyA4A4A4 => getColorHexFromStr('#A4A4A4');
  get greyB4B4B4 => getColorHexFromStr('#B4B4B4');
  get grey4C525E => getColorHexFromStr('#4C525E');
  get grey767676 => getColorHexFromStr('#767676');
  get greyC0C0C0 => getColorHexFromStr('#C0C0C0');
  get greyD3D3D3 => getColorHexFromStr('#D3D3D3');
  get greyDFDFDF => getColorHexFromStr('#DFDFDF');
  get greyE8E8E8 => getColorHexFromStr('#E8E8E8');
  get grey676767 => getColorHexFromStr('#676767');
  get greyF1F1F1 => getColorHexFromStr('#F1F1F1');
  get pinkFFD2D2 => getColorHexFromStr('#FFD2D2');
  get greenDBFFBF => getColorHexFromStr('#DBFFBF');
  get aquaGreen => getColorHexFromStr('#43AD96');
  get aquaBlue => getColorHexFromStr('#0DA6CB');
  get blue21B1C4 => getColorHexFromStr('#21B1C4');
  get white => getColorHexFromStr('#ffffff');
  get accentRed => getColorHexFromStr('#FF5656');
  get accentYellow => getColorHexFromStr('#FFE092');
  get yellowFDCC4E => getColorHexFromStr('#FDCC4E');
  get black4C525E => getColorHexFromStr('#4C525E');
  get blackA4C525E => getColorHexFromStr('#704C525E');
  get blackA24C525E => getColorHexFromStr('#904C525E');
  get bagroundcolor => getColorHexFromStr('#F6F6F8');
  get profilebgcolor => getColorHexFromStr('4C525E');
  get progressGreen => getColorHexFromStr('19F38B');

  get whiteF6F6F8 => getColorHexFromStr('#F6F6F8');
  get whiteF6F6F6 => getColorHexFromStr('#F6F6F6');
  get black242425 => getColorHexFromStr('#242425');
  get black312A2A => getColorHexFromStr('#312A2A');
  get red => getColorHexFromStr('#D6001C');
  get yellowFFF8BA => getColorHexFromStr('#FFF8BA');
  get blueBFFBFF => getColorHexFromStr('#BFFBFF');
  get blueEBFFEF => getColorHexFromStr('#EBFFEF');

  int getColorHexFromStr(String colorStr) {
    colorStr = 'FF$colorStr';
    colorStr = colorStr.replaceAll('#', '');
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            'An error occurred when converting a color');
      }
    }
    return val;
  }

  static final AppColors _appColors = AppColors._internal();
}

AppColors appColors = AppColors();
