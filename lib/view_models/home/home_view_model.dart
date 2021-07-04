import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orbital_app/services/database.dart';

class HomeViewModel extends BaseViewModel {
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  Future init() async {
    runBusyFuture(addToken());
    runBusyFuture(serviceLocator.isReady<GeolocationService>());
  }

  Future addToken() async {
    // Get the token each time the application loads
    String token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await _databaseService.addToken(token);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(_databaseService.addToken);
  }
}