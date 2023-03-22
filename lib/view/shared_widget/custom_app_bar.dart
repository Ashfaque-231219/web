import 'package:flutter/material.dart';

import '../../helper/constants/color_constants.dart';
import '../../helper/constants/font_family.dart';
import '../../helper/constants/image_constants.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: width * 0.4,
        toolbarHeight: height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.darkBrown,
        leading: Container(
          margin: EdgeInsets.only(left: width * 0.1),
          child: Image.asset(ImageConstants.logoImage),
        ),
        actions: [
          SizedBox(
              width: width * 0.6,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Projects",
                        style: TextStyle(fontSize: width * 0.01, fontFamily: FontFamily.montserrat),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.10,
                    ),
                    Text(
                      "Reports",
                      style: TextStyle(fontSize: width * 0.01, fontFamily: FontFamily.montserrat),
                    ),
                    SizedBox(
                      width: width * 0.15,
                    ),
                    SizedBox(
                      width: width * 0.2,
                      child: Row(
                        children: [
                          const Icon(Icons.notification_add),
                          SizedBox(
                            width: width * 0.015,
                          ),
                          Container(
                            width: width * 0.02,
                            height: height * 0.05,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
