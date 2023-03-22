import 'package:flutter/material.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class CustomExpectedDate extends StatelessWidget {
  final bool visible;
  final String text;
  final String date;
  final double size;

  const CustomExpectedDate({Key? key, required this.visible, required this.date, required this.text, this.size = 13.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomLabel(
              text: text,
              size: size,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 40),
              child: CustomLabel(
                text: date,
                size: size,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
