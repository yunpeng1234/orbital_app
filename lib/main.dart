import 'package:flutter/material.dart';
import 'package:orbital_app/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/route_generator.dart';
import 'routes/nav_key.dart';
import 'package:overlay_support/overlay_support.dart';

Future main() async{

  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  await serviceLocator.isReady<GeolocationService>();
  runApp(MyApp());
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
                elevation: 5,
                backgroundColor: appBarColor,
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

