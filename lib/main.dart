import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/route_generator.dart';
import 'routes/nav_key.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';

Future main() async{

  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    toast('${message.notification.title} ${message.notification.body}', duration: Toast.LENGTH_LONG);

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {

  final AuthService _auth = serviceLocator<AuthService>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Individual>.value(
      initialData: null,
      value: _auth.user,
        child: OverlaySupport.global(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: primaryColor,
                foregroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.black),
                centerTitle: true,
              ),
              accentColor: greyButtonColor,
            ),
            navigatorKey: NavKey.navKey,
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
      ),
        ),
    );
  }
}

