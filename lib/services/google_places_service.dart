import 'package:google_place/google_place.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/my_location.dart';
import 'dart:io';

class GooglePlacesService {
  final String apiKey = dotenv.env['PLACES_KEY'];
  final GooglePlace _service = GooglePlace(dotenv.env['PLACES_KEY']);
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  final String urlEndpoint = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=';

  Future<List<MyLocation>> getNearbyLocations() async {
    GeoFirePoint position = await _geolocator.currentPosition();
    List<SearchResult> results = (await _service.search.getNearBySearch(Location(lat: position.latitude, lng: position.longitude), 1000, type: 'restaurant')).results;
    if (results.length > 10) {
     results = results.sublist(0, 10);
    }
    List<MyLocation> locations = await Future.wait(results.map((result) async {
      String placeId = result.placeId;
      var details = await _service.details.get(placeId, fields: "formatted_address");
      if (details == null || details.result == null) {
        if (details != null) print(details.status);
        return null;
      }
      String address = details.result.formattedAddress;
      var reference;
      if (result.photos == null) {
        reference = '';
      } else {
        reference = result.photos.first.photoReference;
      }
      MyLocation loc = MyLocation(
        placeId: result.placeId,
        lat: result.geometry.location.lat,
        long: result.geometry.location.lng,
        name: result.name,
        address: address,
        photoUrl: urlEndpoint + reference + '&key=' + apiKey,
      );
      return loc;
    }).toList());
    locations.removeWhere((elem) => elem == null);
    return locations;
  }

  Future<List<AutocompletePrediction>> placesAutocomplete(String input) async {
    GeoFirePoint position = await _geolocator.currentPosition();
    AutocompleteResponse result = await _service.autocomplete.get(input,
        location: LatLon(position.latitude, position.longitude),
        radius: 20000,
    );
    return result.predictions;
  }
}