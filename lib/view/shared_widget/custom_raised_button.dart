import 'package:flutter/material.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    required this.text,
    required this.color,
    this.size = 13,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 40,
    required this.onPressed,
    this.sideColor = Colors.white,
    this.shadowColor = Colors.black,
    this.elevation = 0.0,
    Key? key,  fontFamily,
  }) : super(key: key);
  final String text;
  final double size;
  final Color color;
  final Color textColor;
  final Color shadowColor;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final double elevation;
  final Color sideColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            elevation: elevation,
            minimumSize: Size(double.infinity, appDimen.sp40),
            shadowColor: shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: sideColor),
            ),
          ),
          onPressed: onPressed,
          child: CustomLabel(
            text: text,
            size: size,
            alignment: TextAlign.center,
            color: textColor,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
