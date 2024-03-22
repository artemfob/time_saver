import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plinkozeusquiz/firebase_options.dart';
import 'package:plinkozeusquiz/services/push_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

const String DEVICE_STATUS_KEY = 'deviceStatus';

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
    _handlePlayerStatus(message);
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      PushNotifications.instance
          .showNotification(flutterLocalNotificationsPlugin, message);
    } else {
      PushNotifications.instance
          .showNotification(flutterLocalNotificationsPlugin, message);
    }
  });
}

Future<String?> _getSavedPlayerStatus() async {
  return await SharedPreferences.getInstance()
      .then((value) => value.getString(DEVICE_STATUS_KEY));
}

Future<void> _saveNewPlayerStatus(String newPlayerStatus) async {
  await SharedPreferences.getInstance()
      .then((value) => value.setString(DEVICE_STATUS_KEY, newPlayerStatus));
}

Future<void> _handlePlayerStatus(RemoteMessage message) async {
  if (message.data['status'] == null) return;

  final messaging = FirebaseMessaging.instance;

  final String? savedStatus = await _getSavedPlayerStatus();

  // if there is no saved status - save status
  // if there status is greater than we have in notification - ignore
  if (savedStatus != null) {
    int parsedSavedStatus = int.parse(savedStatus);
    int notificationStatus = int.parse(message.data['status']);

    if (notificationStatus > parsedSavedStatus) {
      await messaging.unsubscribeFromTopic(savedStatus);
      await messaging.subscribeToTopic(message.data['status']);
      await _saveNewPlayerStatus(message.data['status']);
    }
  } else {
    await _saveNewPlayerStatus(message.data['status']);
  }
}
