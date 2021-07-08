import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'order_service.dart';
import 'database.dart';
import 'package:orbital_app/routes/nav_key.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/models/user.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationService {

  final OrderService _orderService = serviceLocator<OrderService>();
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  void init() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) async {
      if (message != null) {
        String screen = message.data['screen'];
        if (screen == 'myOrders') {
          Order order = await _orderService.getOrder(message.data['args']);
          NavKey.navKey.currentState.pushNamed(message.data['screen'],
              arguments: order);
        } else {
          IndividualData data = await _databaseService.userData.first;
          NavKey.navKey.currentState.pushNamed(message.data['screen'],
              arguments: data);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if(message.data != null) {
        NavKey.navKey.currentState.pushNamed(message.data['screen']);
      }
      // toast('${message.notification.title} ${message.notification.body}', duration: Toast.LENGTH_LONG);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message != null) {
        String screen = message.data['screen'];
        if (screen == 'myOrders') {
          Order order = await _orderService.getOrder(message.data['args']);
          NavKey.navKey.currentState.pushNamed(message.data['screen'],
              arguments: order);
        } else {
          print(message.data['args']);
          IndividualData data = await _databaseService.getSenderData(message.data['args']);
          NavKey.navKey.currentState.pushNamed(message.data['screen'],
              arguments: data);
        }
      }
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}