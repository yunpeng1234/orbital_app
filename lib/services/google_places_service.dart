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
      if (details != null) print(details.status);
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
    print(details.internationalPhoneNumber);
    MyLocation loc = MyLocation(
      placeId: details.placeId,
      lat: details.geometry.location.lat,
      long: details.geometry.location.lng,
      name: details.name,
      address: address,
      photoUrl: urlEndpoint + reference + '&key=' + apiKey,
    );
    return loc;
  }

  Future<List<MyLocation>> getNearbyLocations() async {
    GeoFirePoint position = await _geolocator.currentPosition();
    List<SearchResult> results = (await _service.search.getNearBySearch(Location(lat: position.latitude, lng: position.longitude), 1000, type: 'restaurant')).results;
    if (results.length > 10) {
     results = results.sublist(0, 10);
    }
    // List<MyLocation> locations = await Future.wait(results.map((result) async {
    //   DetailsResult details = await getDetails(result.placeId);
    //   return detailsToLocation(details);
    // }).toList());
    // locations.removeWhere((elem) => elem == null);
    // return locations;
    return resultsListToLocation(results);
  }

  Future<List<AutocompletePrediction>> placesAutocomplete(String input) async {
    GeoFirePoint position = await _geolocator.currentPosition();
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