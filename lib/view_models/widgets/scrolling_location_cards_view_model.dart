import 'package:flutter/cupertino.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ScrollingLocationCardsViewModel<T> extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  final GeolocationService _geolocationService = serviceLocator<GeolocationService>();
  List<MyLocation> locations = [];
  List<String> placeIds;

  Future init(ScrollController controller, int toLoad) async {
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange) {
        getDetails(toLoad);
        this.notifyListeners();
      }
    });
    await runBusyFuture(getDetailsAndPlaceId(toLoad));
  }

  Future getDetailsAndPlaceId(int toLoad) async {
    placeIds = await _service.getNearbyPlaceIds();
    await getDetails(toLoad);
    return;
  }

  Future getDetails(int toLoad) async {
    if (placeIds.length < toLoad) {
      return;
    }
    List<String> toConvert = placeIds.sublist(0, toLoad);
    placeIds.removeRange(0, toLoad);
    locations.addAll(await Future.wait(toConvert.map((placeId) async {
      return await _service.placeIdToLocation(placeId);
    }).toList()));
  }



  Future _getNearbyLocations() async {
    // locations = await runBusyFuture(_service.getNearbyLocations());
    locations = await runBusyFuture(_service.getNearbyLocations());
  }
}