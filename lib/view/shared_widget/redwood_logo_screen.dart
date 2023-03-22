import 'package:flutter/cupertino.dart';

import '../../helper/constants/color_constants.dart';
import '../../helper/constants/image_constants.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({Key? key}) : super(key: key);

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width * 0.5,
      color: ColorConstants.darkBrown,
      child: Center(
          child: SizedBox(
            width: width * 0.3,
            height: height * 0.06,
            child: Image.asset(
              ImageConstants.logoImage,
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
