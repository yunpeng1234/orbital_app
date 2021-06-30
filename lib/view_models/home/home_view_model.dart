import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';
import 'package:geoflutterfire/geoflutterfire.dart';

class HomeViewModel extends BaseViewModel {

  Future init() async {
    runBusyFuture(serviceLocator.isReady<GeolocationService>());
  }
}