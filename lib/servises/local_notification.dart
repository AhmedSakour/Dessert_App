import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class LocalNotification {
  static Future initalize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInialize = AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInialize = DarwinInitializationSettings();
    var inializaSetting =
        InitializationSettings(android: androidInialize, iOS: iosInialize);
    await flutterLocalNotificationsPlugin.initialize(
      inializaSetting,
      onDidReceiveNotificationResponse: (details) async {
        String? payload = details.payload;
        if (payload != null && payload.isNotEmpty) {
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
              payload, (Route<dynamic> route) => false);
        }
      },
    );
  }

  static Future showBigTextNotification(
      {required FlutterLocalNotificationsPlugin fln,
      required String title,
      required String payload,
      required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('aa_mm_9', 'sakour',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);
    var not = NotificationDetails(
        android: androidNotificationDetails, iOS: DarwinNotificationDetails());

    await fln.show(0, title, body, not, payload: payload);
  }
}
