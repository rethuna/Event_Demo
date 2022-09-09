import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_share/flutter_share.dart';

import 'Screens/Home_screen.dart';
import 'config/Global_variable.dart';

Future<void> backroundHandler(RemoteMessage message) async {
  print(" This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalVariable.navState,

      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.yellow, brightness: Brightness.dark),
      home: MyHomePage(),
    );
  }
}
