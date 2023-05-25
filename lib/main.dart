import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intern/screens/screens.dart';
import 'package:intern/services/notification_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: "firebase_messaging",
        channelName: "firebase message",
        channelDescription: "channel for message",
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification
      ),
    ],
  );
    FirebaseMessaging.onBackgroundMessage(NotificationSettingsMethods().backgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}
