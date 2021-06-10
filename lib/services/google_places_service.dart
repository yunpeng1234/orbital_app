import 'package:places_service/places_service.dart';
import 'package:google_place/google_place.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/my_location.dart';

class GooglePlacesService {
  // final PlacesService _service = PlacesService();
  final GooglePlace _service = GooglePlace(dotenv.env['PLACES_KEY']);
  final String photoEndpoint = 'https://maps.googleapis.com/maps/api/place/photo?';

  // void init() {
  //   _service.initialize(apiKey: dotenv.env['PLACES_KEY']);
  // }

  Future getNearbyLocations(double lat, double long) async {
    List results = (await _service.search.getNearBySearch(Location(lat: lat, lng: long), 1000, type: 'restaurant')).results;
    List<MyLocation> locations = await Future.wait(results.map((result) async {
      String placeId = result.placeId;
      var details = (await _service.details.get(placeId, fields: "formatted_address")).result;
      String address = details.formattedAddress;
      var reference = result.photos;
      if (reference == null) {
        reference ='';
      } else {
        reference = result.photos.first.photoReference;
      }
      MyLocation loc = MyLocation(
        placeId: result.placeId,
        lat: result.geometry.location.lat,
        long: result.geometry.location.lng,
        name: result.name,
        address: address,
        photoUrl: photoEndpoint + reference,
      );
      print(loc);
      return loc;
    }).toList());
    return locations;
  }

  // Future getDetails(String placeId) async {
  //   return _service.getPlaceDetails(placeId);
  // }
}