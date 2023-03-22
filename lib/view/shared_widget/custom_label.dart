import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    required this.text,
    this.size = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = '',
    this.alignment = TextAlign.left,
    this.maxLines,
    Key? key,
  }) : super(key: key);

  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final String fontFamily;
  final TextAlign alignment;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      style: montserrat(),
      maxLines: maxLines,
      overflow: TextOverflow.clip,
    );
  }

  TextStyle montserrat() {
    return GoogleFonts.montserrat(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
