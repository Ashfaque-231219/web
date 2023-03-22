import 'package:flutter/cupertino.dart';

import '../../helper/constants/color_constants.dart';
import '../../helper/constants/image_constants.dart';

class RedwoodWeb extends StatefulWidget {
  const RedwoodWeb({Key? key}) : super(key: key);

  @override
  State<RedwoodWeb> createState() => _RedwoodWebState();
}

class _RedwoodWebState extends State<RedwoodWeb> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.5,
      width: width,
      color: ColorConstants.darkBrown,
      child: Center(
          child: SizedBox(
            width: width * 0.45,
            height: height * 0.1,
            child: Image.asset(
              ImageConstants.logoImage,
              fit: BoxFit.fill,
            ),)),
    );
  }
}
