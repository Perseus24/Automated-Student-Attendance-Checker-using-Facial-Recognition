import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/loading_screen.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/screens/notification_page.dart';
import 'package:flutter_application_1/web/web_main.dart';

import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NewNotif newNotif = NewNotif();

  newNotif.initializeNotifications();
  newNotif.setForegroundMessageHandler();
  newNotif.setBackgroundMessageHandler();

  ChatNotification.initializeNotification();
  runApp(
      Main()
  );
}

class Main extends StatelessWidget {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: kIsWeb?MyApp():LoadingScreen(),
      navigatorKey: navigatorKey,
      routes: {
        MainHomePage.id: (context) => MainHomePage(),

      },
    );
  }
}
