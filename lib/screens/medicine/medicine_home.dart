import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intern/screens/screens.dart';
import 'package:intern/services/crud_operations.dart';
import 'package:intern/services/notification_service.dart';

import '../../services/authentication.dart';

class MedicineHomePage extends StatefulWidget {
  const MedicineHomePage({super.key});

  @override
  State<MedicineHomePage> createState() => _MedicineHomePageState();
}

class _MedicineHomePageState extends State<MedicineHomePage> {
  final auth = AuthenticationMethods(FirebaseAuth.instance);
  String? deviceToken = "";

  @override
  void initState() {
    super.initState();
    NotificationSettingsMethods().requestPermission();
    NotificationSettingsMethods().getToken().then((token) {
      setState(() {
        deviceToken = token;
      });
    });
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
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
              backgroundColor: Colors.orange),
        );
      },
    );
  }

  // sign out users
  signOut() async {
    await auth.signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => AddMedicinePage(deviceToken: deviceToken!),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder(
            stream: MedicineDbMethods().fetchALlMedicines(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var medicines = snapshot.data!.docs;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: medicines.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: ListTile(
                          title: Text(e['title']),
                          trailing: const Icon(Icons.chevron_right),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          tileColor: Colors.grey,
                        ),
                      );
                    }).toList());
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
