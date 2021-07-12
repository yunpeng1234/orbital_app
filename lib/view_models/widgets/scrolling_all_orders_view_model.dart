import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:place_picker/place_picker.dart';

class ScrollingAllOrdersViewModel extends BaseViewModel {

  final OrderService _database = serviceLocator<OrderService>();
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  Stream<List<Order>> orders;
  GeoFirePoint chosenLocation;

  Future init() async {
    _geolocator.listenToPosition((position) {
      print('here');
     _getNearbyOrders();
     notifyListeners();
    });
    _getNearbyOrders();
  }

  void _getNearbyOrders()  {
    orders = _database.defaultFilter();
  }

  void _getNearbyOrdersFiltered() {
    orders = _database.filteredByLocationAndDestination(chosenLocation);
    notifyListeners();
  }

  GeoFirePoint _converter(LocationResult result) {
    return GeoFirePoint(result.latLng.latitude, result.latLng.longitude);
  }

  Future<void> showPlacePicker() async {
    // LocationResult result = await navKey.currentState.pushNamed('placePicker');
    LocationResult result = await navKey.currentState.push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(dotenv.env['PLACES_KEY'])));
    chosenLocation = _converter(result);
     _getNearbyOrdersFiltered();
  }
}