import 'dart:async';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tuple/tuple.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';

class MySearchBarViewModel extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  List<Tuple3<String, String, String>> predictions = [Tuple3<String, String, String>('1', 'Enter your search!', '')];
  FloatingSearchBarController _controller;

  void init(FloatingSearchBarController controller) {
    _controller = controller;
  }

  Future getAutocomplete(String input) async {
    predictions = (await _service.placesAutocomplete(input)).map(
        (prediction) => Tuple3<String, String, String>(
            prediction.placeId,
            prediction.structuredFormatting.mainText,
            prediction.structuredFormatting.secondaryText,)
    ).toList();
    notifyListeners();
  }

  Future navigateToLocation(Tuple3<String, String, String> prediction) async {
    MyLocation location = await runBusyFuture(_service.placeIdToLocation(prediction.item1));
    _controller.close();
    super.navigate('location', arguments: location);
  }
}