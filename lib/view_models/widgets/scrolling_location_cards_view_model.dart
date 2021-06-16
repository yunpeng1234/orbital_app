import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/services/dummy_database.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';

class ScrollingLocationCardsViewModel<T> extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  Future<List<MyLocation>> locations;

  Future getNearbyLocations() async {
    locations = _service.getNearbyLocations();
  }
}