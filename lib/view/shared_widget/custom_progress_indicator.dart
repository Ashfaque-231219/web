import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
