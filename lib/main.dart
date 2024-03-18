import 'package:app_generator/firebase_options.dart';
import 'package:app_generator/services/push_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(const App());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  print('>>>> TOKEN ${await FirebaseMessaging.instance.getToken()}');

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
