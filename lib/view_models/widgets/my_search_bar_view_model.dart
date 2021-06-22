import 'dart:async';
import 'package:tuple/tuple.dart';
import 'package:google_place/google_place.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/google_places_service.dart';

class MySearchBarViewModel extends BaseViewModel {
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  List<Tuple2<String, String>> predictions = [Tuple2<String, String>('Title', 'Subtitle')];

  Future getAutocomplete(String input) async {
    predictions = (await _service.placesAutocomplete(input)).map(
        (prediction) => Tuple2<String, String>(
            prediction.structuredFormatting.mainText,
            prediction.structuredFormatting.secondaryText,)
    ).toList();
    notifyListeners();
  }
}