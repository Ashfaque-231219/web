import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/image_constants.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/route_generator.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/authBloc/login_event.dart';
import 'package:web/view-model/authBloc/login_state.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/nav_bar.dart';

class AutoWrapper extends StatefulWidget {
  const AutoWrapper({/*this.child,*/ Key? key}) : super(key: key);

  // final Widget? child;

  @override
  State<AutoWrapper> createState() => _AutoWrapperState();
}

class _AutoWrapperState extends State<AutoWrapper> {
  Widget child = Container();
  String route = '';
  String? image = '';
  String? names = '';
  String? emails = '';
  bool showNotification = false;
  String androidUrl = '';
  String androidVersion = '';
  String iosUrl = '';
  String iosVersion = '';

  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    // child = widget.child;
    getData();
    setData();
    super.initState();
  }

  getData() async {
    androidUrl = await SharedPref.getString(key: "android-url");
    androidVersion = await SharedPref.getString(key: "android-version");
    iosUrl = await SharedPref.getString(key: "ios-url");
    iosVersion = await SharedPref.getString(key: "ios-version");
    setState(() {});
  }

  setData() async {
    await SharedPref.setString(key: "login", data: "login");
    await SharedPref.setBool(key: "User-detail", data: false);
    // void function() async {
    //   image = await SharedPref.getString(key: "user-Image");
    //   names = await SharedPref.getString(key: "user-name");
    //   emails = await SharedPref.getString(key: "user-email");
    // }

    html.window.onBeforeUnload.listen((event) async {
      token = await SharedPref.getString(key: "login");
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    route = ModalRoute.of(context)!.settings.name.toString();

    debugPrint("route: $route");
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
          final String? name = state.name;
          final String? email = state.email;
          final String image = state.image ?? "";

          return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
            if (width > SizeConstants.tabWidth) {
              return Scaffold(
                appBar: AppBar(
                  leadingWidth: width * 0.4,
                  toolbarHeight: height * 0.1,
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorConstants.darkBrown,
                  leading: Container(
                    margin: EdgeInsets.only(left: width * 0.1),
                    child: Image.asset(ImageConstants.redwoodLogo),
                  ),
                  actions: [
                    SizedBox(
                      width: width * 0.6,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    context.router.pushNamed(RoutesConst.projects);
                                    setState(() {});
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomLabel(
                                        text: 'Projects',
                                        size: appDimen.sp15,
                                        color: Colors.white,
                                        fontWeight: context.router.isPathActive(RoutesConst.projects)
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                      Visibility(
                                        visible: context.router.isPathActive(RoutesConst.projects),
                                        child: Container(
                                          width: appDimen.sp60,
                                          height: appDimen.sp3,
                                          margin: EdgeInsets.symmetric(
                                            vertical: appDimen.sp5,
                                            horizontal: appDimen.sp2,
                                          ),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              width: width * 0.10,
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  context.router.pushNamed(RoutesConst.reports);
                                  setState(() {});
                                  //print
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomLabel(
                                      text: 'Reports',
                                      size: appDimen.sp15,
                                      color: Colors.white,
                                      fontWeight: context.router.isPathActive(RoutesConst.reports)
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                    Visibility(
                                      visible: context.router.isPathActive(RoutesConst.reports),
                                      child: Container(
                                        width: appDimen.sp60,
                                        height: appDimen.sp3,
                                        margin: EdgeInsets.symmetric(
                                          vertical: appDimen.sp5,
                                          horizontal: appDimen.sp2,
                                        ),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.15,
                            ),
                            SizedBox(
                              width: width * 0.2,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.router.pushNamed(RoutesConst.notifications).then(
                                          (value) => {triggerAddItemEvent(GetUserDetailsEvent(context: context))});
                                    },
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: appDimen.sp30,
                                          height: appDimen.sp30,
                                          child: const Icon(Icons.notifications_outlined),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: SizedBox(
                                            width: appDimen.sp40,
                                            height: appDimen.sp40,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Lottie.asset(
                                                ImageConstants.notificationDot,
                                                repeat: true,
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  PopupMenuButton(
                                    child: SizedBox(
                                      width: width * 0.02,
                                      height: width * 0.02,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          image,
                                          height: width * 0.02,
                                          width: width * 0.02,
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, url, error) => Image.asset(
                                            appImages.projectInfo,
                                            height: width * 0.05,
                                            width: width * 0.05,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        value: 1,
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: height * 0.012,
                                              ),
                                              SizedBox(
                                                width: width * 0.05,
                                                height: width * 0.05,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.network(
                                                    image.toString(),
                                                    height: width * 0.05,
                                                    width: width * 0.05,
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context, url, error) => Image.asset(
                                                      appImages.projectInfo,
                                                      height: width * 0.05,
                                                      width: width * 0.05,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.012,
                                              ),
                                              Text(
                                                name ?? "",
                                                style: const TextStyle(fontSize: 12.54),
                                              ),
                                              SizedBox(
                                                height: height * 0.005,
                                              ),
                                              Text(
                                                email ?? "",
                                                style: TextStyle(fontSize: width * 0.007),
                                              ),
                                              SizedBox(
                                                height: height * 0.018,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        height: height * 0.04,
                                        onTap: () {
                                          context.router.pushNamed(RoutesConst.editProfile).then(
                                              (value) => {triggerAddItemEvent(GetUserDetailsEvent(context: context))});
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: width * 0.01,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Edit Profile",
                                                style: TextStyle(fontSize: width * 0.01),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        height: height * 0.04,
                                        onTap: () {
                                          context.router.pushNamed(RoutesConst.changePass).then(
                                              (value) => {triggerAddItemEvent(GetUserDetailsEvent(context: context))});
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.lock_outline_sharp,
                                              size: width * 0.01,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Text(
                                              "Change Password",
                                              style: TextStyle(fontSize: width * 0.01),
                                            )
                                          ],
                                        ),
                                      ),
                                      /*PopupMenuItem(
                                        height: height * 0.04,
                                        onTap: () {
                                          setState(() {
                                            showNotification = !showNotification;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Notification",
                                              style: TextStyle(fontSize: width * 0.01),
                                            ),
                                            FlutterSwitch(
                                              height: 23,
                                              width: 38,
                                              activeColor: ColorConstants.darkBrown,
                                              inactiveColor: ColorConstants.lightGrey,
                                              toggleSize: 25,
                                              padding: 1,
                                              value: showNotification,
                                              onToggle: (val) async {
                                                setState(() {
                                                  showNotification = val;
                                                });
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),*/
                                      PopupMenuItem(
                                        height: height * 0.02,
                                        enabled: false,
                                        child: const Divider(),
                                      ),
                                      PopupMenuItem(
                                        height: height * 0.04,
                                        onTap: () {
                                          context.router.pushNamed(RoutesConst.contactAdmin).then(
                                              (value) => {triggerAddItemEvent(GetUserDetailsEvent(context: context))});
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Contact Admin",
                                              style: TextStyle(fontSize: width * 0.01),
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: width * 0.01,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        height: height * 0.04,
                                        enabled: false,
                                        child: SizedBox(
                                          width: width * 0.15,
                                          height: 50,
                                        ),
                                      ),
                                      PopupMenuItem(
                                        height: height * 0.04,
                                        value: 1,
                                        onTap: () {
                                          triggerAddItemEvent(LogoutEvent(context: context));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              size: width * 0.01,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: width * 0.005,
                                            ),
                                            Expanded(
                                              child: CustomLabel(
                                                text: "Logout",
                                                size: width * 0.01,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // body: child,
                body: const AutoRouter(),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.13),
                  width: width,
                  height: height * 0.08,
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(ImageConstants.hollmarkImage, width: width * 0.01),
                            SizedBox(
                              width: width * 0.002,
                            ),
                            CustomLabel(
                              text: "Copyright 2021.All rights reserved",
                              size: appDimen.sp11,
                              fontWeight: FontWeight.w400,
                              color: Color(appColors.brown840000),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              mouseCursor: SystemMouseCursors.click,
                              onTap: () {
                                openUrl(androidUrl);
                              },
                              child: Tooltip(
                                message: "Android Version $androidVersion",
                                child: SvgPicture.asset(
                                  appImages.android,
                                  width: appDimen.sp25,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: appDimen.sp20,
                            ),
                            InkWell(
                              mouseCursor: SystemMouseCursors.click,
                              onTap: () {
                                openUrl(iosUrl);
                              },
                              child: Tooltip(
                                message: "Apple Version $iosVersion",
                                child: SvgPicture.asset(
                                  appImages.apple,
                                  width: appDimen.sp25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                drawer: NavBar(
                  homeContext: context,
                  images: image,
                  name: name,
                  emails: email,
                ),
                appBar: AppBar(
                  title: const Text("Redwood"),
                  backgroundColor: ColorConstants.darkBrown,
                ),
                // body: child,
                body: const AutoRouter(),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.13),
                  width: width,
                  height: height * 0.08,
                  color: Colors.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*Image.asset(ImageConstants.hollmarkImage,),
                            SizedBox(
                              width: width * 0.002,
                            ),*/
                        CustomLabel(
                          text: "© Copyright 2021.All rights reserved",
                          size: appDimen.sp11,
                          fontWeight: FontWeight.w400,
                          color: Color(appColors.brown840000),
                        ),
                        Row(
                          children: [
                            InkWell(
                              mouseCursor: SystemMouseCursors.click,
                              onTap: () {
                                openUrl(androidUrl);
                              },
                              child: Tooltip(
                                message: "Android Version $androidVersion",
                                child: SvgPicture.asset(
                                  appImages.android,
                                  width: appDimen.sp25,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: appDimen.sp20,
                            ),
                            InkWell(
                              mouseCursor: SystemMouseCursors.click,
                              onTap: () {
                                openUrl(iosUrl);
                              },
                              child: Tooltip(
                                message: "Apple Version $iosVersion",
                                child: SvgPicture.asset(
                                  appImages.apple,
                                  width: appDimen.sp25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
