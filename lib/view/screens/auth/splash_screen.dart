import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/main.dart';
import 'package:web/route_generator.dart';

import '../../../helper/constants/image_constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getPermission();
    messageListener();
    super.initState();
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            print('android firebase initiated');
            startTime();
            return Scaffold(
              body: initScreen(context),
            );
          }
          return Scaffold(
            body: initScreen(context),
          );
        });
  }

  route() async {
    var pref = await SharedPreferences.getInstance();
    var walkVisited = pref.getBool("remember_me");
    var userLogin = pref.getBool("User-detail");
    navigate(walkVisited ?? false, userLogin ?? false);
  }

  navigate(
    bool walkVisited,
    bool userLogin,
  ) {
    if (walkVisited == true) {
      context.router.replaceNamed(RoutesConst.homePage);
      // context.go('/home-page');
      context.pushRoute(const Projects());
      context.router.removeLast();
      // Navigator.pushReplacementNamed(context, RoutesConst.homePage + RoutesConst.projects);
    } else if (userLogin == true) {
      context.router.replaceNamed(RoutesConst.homePage);
      // context.go('/home-page');
      // context.pushRoute(const Projects());
      context.router.removeLast();
      // Navigator.pushReplacementNamed(context, RoutesConst.homePage + RoutesConst.projects);
    } else {
      context.router.replaceNamed(RoutesConst.login);
      // context.go('/home-page');
      // context.pushRoute(const HomeRouter());
      context.router.removeLast();
      // Navigator.pushReplacementNamed(context, RoutesConst.login);
    }
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void messageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null && navigatorKey.currentState!=null) {
        print('Message also contained a notification: ${message.notification?.body}');
        showCustomAlert(
          context: navigatorKey.currentState!.context,
          title: message.notification?.title ?? '',
          message: message.notification?.body ?? '',
            notification: true,
        );
        // showDialog(
        //     context: navigatorKey.currentState!.context,
        //     builder: ((BuildContext context) {
        //       return DynamicDialog(title: message.notification?.title, body: message.notification?.body);
        //     }));
      }
    });
  }

  initScreen(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConstants.darkBrown,
      width: width,
      height: height,
      child: Center(
        child: Container(
            color: ColorConstants.darkBrown,
            width: width * 0.7,
            height: height * 0.33,
            child: Center(
              child: Container(
                width: width * 0.4,
                height: width * 0.04,
                color: ColorConstants.darkBrown,
                child: Image.asset(
                  ImageConstants.logoImage,
                  fit: BoxFit.fill,
                ),
              ),
            )),
      ),
    );
  }
}
