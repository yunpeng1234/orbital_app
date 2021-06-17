import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:place_picker/place_picker.dart';

class ScrollingOrderCardsViewModel<T> extends BaseViewModel {
  final DatabaseService _database = serviceLocator<DatabaseService>();
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  Stream<List<Order>> orders;
  // StreamController<List<Order>> controller = StreamController<List<Order>>.broadcast();
  GeoFirePoint userLocation;
  GeoFirePoint chosenLocation;

  Future getCurrentPosition() async {
    userLocation = await runBusyFuture(_geolocator.currentPosition());
    getNearbyOrders();
  }

  // Future getNearbyOrders() async {
  //   GeoFirePoint position = await _geolocator.currentPosition();
  //   // orders = _database.filteredByLocation(position);
  //   controller.add(await _database.filteredByLocation(position).first);
  // }

  void getNearbyOrders()  {
    orders = _database.filteredByLocation(userLocation);
  }

  void _getNearbyOrdersFiltered() {
    orders = _database.filteredByLocationAndDestination(userLocation, chosenLocation);
    notifyListeners();
  }

  GeoFirePoint _converter(LocationResult result) {
    return GeoFirePoint(result.latLng.latitude, result.latLng.longitude);
  }

  void showPlacePicker() async {
    // LocationResult result = await navState.pushNamed('placePicker');
    LocationResult result = await navState.push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(dotenv.env['PLACES_KEY'])));
    chosenLocation = _converter(result);
    await _getNearbyOrdersFiltered();
  }

}