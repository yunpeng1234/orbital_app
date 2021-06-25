import 'dart:async';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';

class SearchResultsViewModel extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  List<MyLocation> results;

  Future init(String query) async {
    runBusyFuture(textSearch(query));
  }

  Future textSearch(String query) async {
    results = await _service.textSearch(query);
  }
}