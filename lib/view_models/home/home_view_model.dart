import 'package:orbital_app/models/my_location.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';
import 'package:geoflutterfire/geoflutterfire.dart';

class HomeViewModel extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  List<MyLocation> locations;
  GeoFirePoint chosenLocation;

  Future getNearbyLocations() async {
    locations = await runBusyFuture(_service.getNearbyLocations());
  }
}