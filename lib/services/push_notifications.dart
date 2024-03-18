import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  PushNotifications._();

  static final instance = PushNotifications._();

  final messaging = FirebaseMessaging.instance;

  // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   if (kDebugMode) {
  //     print("Handling a background message: ${message.messageId}");
  //     print('Message data: ${message.data}');
  //     print('Message notification: ${message.notification?.title}');
  //     print('Message notification: ${message.notification?.body}');
  //   }
  // }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final Response response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    return response.data;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RemoteMessage message) async {
    // Define Android notification details
    // final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
    //       await _getByteArrayFromUrl('https://dummyimage.com/48x48'));

    AndroidNotificationDetails androidPlatformChannelSpecifics;

    if (message.data['imageUrl'] != null) {
      final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
          await _getByteArrayFromUrl(message.data['imageUrl']));

      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(bigPicture,
              // largeIcon: largeIcon,
              // contentTitle: 'overridden <b>big</b> content title',
              htmlFormatContentTitle: true,
              // summaryText: 'summary <i>text</i>',
              htmlFormatSummaryText: true);

      androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your_channel_id', 'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: bigPictureStyleInformation,
          ticker: 'ticker');
    } else {
      androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          'your_channel_id', 'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
    }

    // Define platform notification details
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics); // Enable sound on iOS

    // Show the notification

    await flutterLocalNotificationsPlugin.show(
      message.messageId
          .hashCode, // Replace with a unique notification ID if needed
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      // payload: message., // Optional payload for notification data
    );
  }
}
