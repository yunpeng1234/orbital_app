import 'package:flutter/cupertino.dart';
import 'package:orbital_app/models/my_location.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class ScrollingLocationCardsViewModel<T> extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  final ScrollController controller = ScrollController();
  List<MyLocation> locations = [];
  List<String> placeIds;

  Future init() async {
    await runBusyFuture(initFunc());
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        getData();
        this.notifyListeners();
      }
    });
    print(locations);
    // _getNearbyLocations();
  }

  Future initFunc() async {
    placeIds = await _service.getNearbyPlaceIds();
    await getData();
    return;
  }

  Future getData() async {
    if (placeIds.length < 5) {
      return;
    }
    List<String> toConvert = placeIds.sublist(0, 5);
    placeIds.removeRange(0, 5);
    locations.addAll(await Future.wait(toConvert.map((placeId) async {
      return await _service.placeIdToLocation(placeId);
    }).toList()));
  }



  Future _getNearbyLocations() async {
    // locations = await runBusyFuture(_service.getNearbyLocations());
    locations = await runBusyFuture(_service.getNearbyLocations());
  }
}