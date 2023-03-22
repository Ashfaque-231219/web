import 'package:flutter/material.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/string.dart';

class CustomHeading extends StatelessWidget {
  final String leftHeading;

  // final String rightheading;
  const CustomHeading({
    Key? key,
    required this.leftHeading,
    // required this.rightheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(appDimen.sp10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftHeading,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: appDimen.sp18),
          ),
          GestureDetector(
            child: Row(
              children: [
                Text(appString.showAll),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: appDimen.sp16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
