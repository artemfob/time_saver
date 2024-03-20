import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plinkozeusquiz/firebase_options.dart';
import 'package:plinkozeusquiz/services/push_notifications.dart';

import 'app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebaseWithNotifications();
  runApp(const App());
}

Future<void> initFirebaseWithNotifications() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.requestPermission();
  HttpOverrides.global = MyHttpOverrides();

  print('>>>> TOKEN ${await FirebaseMessaging.instance.getToken()}');

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/icon'),
  ));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      PushNotifications.instance
          .showNotification(flutterLocalNotificationsPlugin, message);
    } else {
      PushNotifications.instance
          .showNotification(flutterLocalNotificationsPlugin, message);
    }
  });
}
