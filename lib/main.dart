import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Routing/route_guard.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/firebase_options.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/injection_container.dart' as di;
import 'package:web/view-model/bloc_provider.dart';

import 'view-model/bloc_observer.dart';

late final AppRouter appRouter;
GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // setPathUrlStrategy();
  await di.init();
  BlocOverrides.runZoned(() => runApp(const MyApp()), blocObserver: CustomBlocObserver());
}

final _appRouter = AppRouter(routeGuard: RouteGuard(), navigatorKey: navigatorKey);
// final _router = AppRoute(SharedPref()).router;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getPermission();
    messageListener();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CustomBlocProvider(
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldKey,
        debugShowCheckedModeBanner: false,
        title: "Redwood",
        // home: Splash(),
        // onGenerateRoute: RoutesConst.generateRoute,
        // initialRoute: RoutesConst.splash,
        // routerConfig: _router,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        // routeInformationProvider: _router.routeInformationProvider,
        // routeInformationParser: _router.routeInformationParser,
        // routerDelegate: _router.routerDelegate,
      ),
    );
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

    final fcmToken = await messaging.getToken();
    print("token: $fcmToken");
  }

  void messageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification?.body}');
        showCustomAlert(
            context: navigatorKey.currentState!.context,
            title: message.notification?.title ?? '',
            message: message.notification?.body ?? '',
            notification: true);
      }
    });
  }
}

//
// late final  _router = GoRouter(
//   debugLogDiagnostics: true,
//   routes: <GoRoute>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) => const Test(),
//     ),
//     GoRoute(
//       path: '/next',
//       builder: (BuildContext context,
//           GoRouterState state) => const NextPage(),
//     ),
//   x
// );
