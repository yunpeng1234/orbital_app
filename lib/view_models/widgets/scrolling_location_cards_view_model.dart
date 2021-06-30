import 'package:flutter/cupertino.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class ScrollingLocationCardsViewModel<T> extends BaseViewModel {
  final int _maxPages = 3;
  final int toLoad = 3;
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  final GeolocationService _geolocationService = serviceLocator<GeolocationService>();
  List<MyLocation> locations = [];
  List<String> placeIds = [];
  int page = 0;


  Future init(ScrollController controller) async {
    _geolocationService.listenToPosition((position) {
      page = 0;
      if (locations.isNotEmpty) locations.clear();
      runBusyFuture(getDetailsAndPlaceId());
    });
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange) {
        getDetails();
        this.notifyListeners();
      }
    });
    if (placeIds.isEmpty) runBusyFuture(getDetailsAndPlaceId());
  }

  int maxItems() {
    return _maxPages * toLoad;
  }

  Future getDetailsAndPlaceId() async {
    placeIds = await _service.getNearbyPlaceIds();
    await getDetails();
    return;
  }

  Future getDetails() async {
    if (placeIds.length < toLoad || page >= _maxPages) {
      return;
    }
    List<String> toConvert = placeIds.sublist(0, toLoad);
    placeIds.removeRange(0, toLoad);
    locations.addAll(await Future.wait(toConvert.map((placeId) async {
      return await _service.placeIdToLocation(placeId);
    }).toList()));
    page++;
  }



  Future _getNearbyLocations() async {
    // locations = await runBusyFuture(_service.getNearbyLocations());
    locations = await runBusyFuture(_service.getNearbyLocations());
  }
}