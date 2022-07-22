import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const InitializationSettings _initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    await _notificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: (payload) async {
      //perform Navigation type stuff here
    });
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      NotificationDetails _notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
        "propertybox",
        "property box channel",
        "This is property box app channel",
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      ));

      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, _notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }
}
