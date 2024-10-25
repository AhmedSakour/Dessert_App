import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_delivery/constant/app_keys.dart';
import 'package:food_delivery/servises/local_notification.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationFirebase {
  final firebaseMessaging = FirebaseMessaging.instance;
  final url = 'https://fcm.googleapis.com/fcm/send';
  Future<String> getAccessToken() async {
    final serviceAccountJson = AppKeys.serviceAccountkeys;
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);

    client.close();
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage() async {
    final String serverKey = await getAccessToken();
    String fcmEndpoint = AppKeys.fcmEndpointKey;
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> message = {};
    message = {
      'message': {
        'token': currentFCMToken,
        'notification': {'body': 'New item added', 'title': 'Hello dear'},
        'data': {
          'current_user_fcm_token': currentFCMToken,
        },
      }
    };
    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
    foreGroundMessage();
  }

  foreGroundMessage() {
    FirebaseMessaging.onMessage.listen((event) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      LocalNotification.showBigTextNotification(
          payload: 'authWrapper',
          fln: flutterLocalNotificationsPlugin,
          title: 'Hello dear',
          body: 'New item added');
    });
  }
}
