// a function that request the permisson to allow for notifications
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationSettingsMethods {
  // a function that pops up a permission dialogue
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User grannted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  // get the phone token function of the firebase_messaging
  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

// testing things
  Future<void> backgroundHandler(RemoteMessage message) async {
    String? title = message.notification!.title;
    String? body = message.notification!.body;
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 123,
        channelKey: "firebase_messaging",
        color: Colors.white,
        title: title,
        body: body,
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: true,
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> sendPushNotification(deviceToken) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAOgSMkN0:APA91bGdDHmga4Cpp4jg12LlHEq47lTXy-dma8JjL5V22jBThSBjj6fu2MUUAe9Ybd5nd0F4HJM_Wo3oioHfhuBfR-wj5kjmMqwe5lA8ziVlChzFo4zvAb8Q8bN8K8etJDfU9zhk2NyH',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "Medicine Added to DB",
              'title': 'trackaHealth',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': deviceToken,
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
