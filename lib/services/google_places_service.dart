import 'package:google_place/google_place.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/my_location.dart';

class GooglePlacesService {
  final String apiKey = dotenv.env['PLACES_KEY'];
  final GooglePlace _service = GooglePlace(dotenv.env['PLACES_KEY']);
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  final String urlEndpoint = 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=';
  int queryCount = 0;

  Future<List<MyLocation>> resultsListToLocation(List<SearchResult> results) async {
    List<MyLocation> locations = await Future.wait(results.map((result) async {
      DetailsResult details = await getDetails(result.placeId);
      return detailsToLocation(details);
    }).toList());
    locations.removeWhere((elem) => elem == null);
    return locations;
  }

  Future<MyLocation> placeIdToLocation(String placeId) async {
    DetailsResult details = await getDetails(placeId);
    return detailsToLocation(details);
  }

  Future<DetailsResult> getDetails(String placeId) async {
    String fields = 'place_id,geometry,name,formatted_address,photo';
    DetailsResponse details = await _service.details.get(placeId, fields: fields);
    if (details == null || details.result == null) {
      return null;
    }
    return details.result;
  }

  MyLocation detailsToLocation(DetailsResult details) {
    String address = details.formattedAddress;
    var reference;
    if (details.photos == null) {
      reference = '';
    } else {
      reference = details.photos.first.photoReference;
    }
    MyLocation loc = MyLocation(
      placeId: details.placeId,
      lat: details.geometry.location.lat,
      long: details.geometry.location.lng,
      name: details.name,
      address: address,
      photoUrl: urlEndpoint + reference + '&key=' + apiKey,
    );
    queryCount++;
    print(queryCount);
    return loc;
  }

  Future<List<MyLocation>> getNearbyLocations() async {
    GeoFirePoint position =  _geolocator.currentPosition();
    List<SearchResult> results = (await _service.search.getNearBySearch(Location(lat: position.latitude, lng: position.longitude), 500, type: 'restaurant')).results;
    if (results.length > 4) {
     results = results.sublist(0, 4);
    }
    // List<MyLocation> locations = await Future.wait(results.map((result) async {
    //   DetailsResult details = await getDetails(result.placeId);
    //   return detailsToLocation(details);
    // }).toList());
    // locations.removeWhere((elem) => elem == null);
    // return locations;
    return resultsListToLocation(results);
  }

  Future<List<String>> getNearbyPlaceIds() async {
    GeoFirePoint position = _geolocator.currentPosition();
    List<SearchResult> results = (await _service.search.getNearBySearch(
        Location(lat: position.latitude, lng: position.longitude), 500,
        type: 'restaurant')).results;
    return results.map((result) => result.placeId).toList();
  }

  Future<List<AutocompletePrediction>> placesAutocomplete(String input) async {
    GeoFirePoint position = _geolocator.currentPosition();
    AutocompleteResponse result = await _service.autocomplete.get(input,
      location: LatLon(position.latitude, position.longitude),
      radius: 2000,
      types: 'establishment',
    );
    return result.predictions;
  }

  Future<List<MyLocation>> textSearch(String query) async {
    TextSearchResponse searchResults = await _service.search.getTextSearch(query);
    return resultsListToLocation(searchResults.results);
  }
}