import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/services/dummy_database.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';
import 'package:geoflutterfire/geoflutterfire.dart';

class ScrollingOrderCardsViewModel<T> extends BaseViewModel {
  final DatabaseService _database = serviceLocator<DatabaseService>();
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  Stream<List<Order>> orders;

  Future getNearbyOrders() async {
    GeoFirePoint position = await _geolocator.currentPosition();
    orders = _database.filteredByLocation(position);
  }
}