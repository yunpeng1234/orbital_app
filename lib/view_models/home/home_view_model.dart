import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/view_models/widgets/scrolling_all_orders_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_location_cards_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_my_orders_view_model.dart';

import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orbital_app/services/database.dart';

class HomeViewModel extends BaseViewModel {
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

  Future init() async {
    runBusyFuture(addToken());
    // runBusyFuture(awaitServices());
  }

  Future addToken() async {
    // Get the token each time the application loads
    String token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await _databaseService.addToken(token);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(_databaseService.addToken);
  }

  Future awaitServices() async {
    Future a = serviceLocator.isReady<GeolocationService>();
    Future b = serviceLocator.isReady<ScrollingLocationCardsViewModel>();
    Future c = serviceLocator.isReady<ScrollingAllOrdersViewModel>();
    Future d = serviceLocator.isReady<ScrollingMyOrdersViewModel>();
    return await Future.wait([a, b, c ,d]);
  }
}