import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PushNotificationService {
  static Future<void> firebaseMesajArkaplan(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('BackGround: ${message.messageId}');
  }

  Future<void> pushAPI() async {
    await Firebase.initializeApp();
    // Android notification channel
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Kullanıcı izinleri
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("Kullanıcı izin durumu: ${settings.authorizationStatus}");
    final _url = Uri.parse("http://82.153.241.111/register_token.php");
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await http.post(_url, body: {'token': token});
      print('Token gönderildi: $token');
    }


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // name
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);
