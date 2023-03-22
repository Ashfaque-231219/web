import 'package:flutter/material.dart';

class WebsiteWrapperPage extends StatefulWidget {
  const WebsiteWrapperPage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<WebsiteWrapperPage> createState() => _WebsiteWrapperPageState();
}

class _WebsiteWrapperPageState extends State<WebsiteWrapperPage> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
