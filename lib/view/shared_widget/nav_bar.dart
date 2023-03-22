import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/font_family.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/route_generator.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/authBloc/login_event.dart';
import 'package:web/view-model/authBloc/login_state.dart';

class NavBar extends StatefulWidget {
  final BuildContext homeContext;
  final String images;
  final String? name;
  final String? emails;

  const NavBar({Key? key, required this.homeContext, required this.images, required this.name, required this.emails}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  bool showNotification = false;
  bool showReminder = false;
  late var pref = "";
  bool logged = false;
  bool subscribed = false;
  String profileImgPath = "";
  String? image;
  String? names = "";
  String? emails = "";

  triggerCreateAccountEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      print("image==${widget.name}");
      // final String? createdAt = state.date;

      return Container(
        height: height,
        width: width * 0.8,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            // Remove padding
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 56,
                          width: 56,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: widget.images != null
                                  ? Image.network(
                                      widget.images,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, url, error) => Image.asset(
                                        appImages.projectInfo,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const Icon(Icons.person)
                              // Image.network(, fit: BoxFit.cover,)
                              // Image.file(File("")),
                              ),
                        ),
                        Flexible(
                          child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: width * 0.5,
                                      child: Text(
                                        widget.name ?? "",
                                        style: TextStyle(
                                          fontFamily: FontFamily.montserrat,
                                          fontWeight: FontWeight.bold,
                                          fontSize: width * 0.05,
                                          color: ColorConstants.darkBrown,
                                        ),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      width: width * 0.6,
                                      child: Text(
                                        widget.emails ?? "",
                                        style: TextStyle(
                                            fontFamily: FontFamily.montserrat,
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.03,
                                            color: ColorConstants.darkBrown),
                                      ))
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: sideMenuView("Projects"),
                    onTap: () {
                      context.router.pushNamed(RoutesConst.homePage + RoutesConst.projects);
                      setState(() {});
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: sideMenuView("Reports"),
                    onTap: () {
                      context.router.pushNamed(RoutesConst.homePage + RoutesConst.reports);
                      setState(() {});
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: sideMenuView("Edit Profile"),
                    onTap: () {
                      context.router.pushNamed(RoutesConst.editProfile);
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: sideMenuView("Change password"),
                    onTap: () {
                      context.router.pushNamed(RoutesConst.changePass);
                      Navigator.pop(context);
                    },
                  ),
                  // const Divider(),
                  // ListTile(
                  //   title: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       sideMenuView("Notification"),
                  //       FlutterSwitch(
                  //           height: 23,
                  //           width: 38,
                  //           activeColor: ColorConstants.darkBrown,
                  //           inactiveColor: ColorConstants.lightGrey,
                  //           toggleSize: 25,
                  //           padding: 1,
                  //           value: showNotification,
                  //           onToggle: (val) async {
                  //             setState(() {
                  //               showNotification = val;
                  //             });
                  //           }),
                  //     ],
                  //   ),
                  //   onTap: () {},
                  // ),
                  const Divider(),
                  ListTile(
                    title: sideMenuView("Contact Admin"),
                    onTap: () {
                      context.router
                          .pushNamed(RoutesConst.contactAdmin)
                          .then((value) => {triggerCreateAccountEvent(GetUserDetailsEvent(context: context))});
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: sideMenuView("Logout"),
                    onTap: () async {
                      triggerCreateAccountEvent(LogoutEvent(context: context));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget sideMenuView(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.montserrat,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: ColorConstants.darkBrown,
            ),
          )
        ],
      ),
    );
  }
}
