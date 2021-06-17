import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoder/geocoder.dart' as GeoC;
import 'google_places_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeolocationService {
  final String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  final String apiKey = dotenv.env['PLACES_KEY'];

  Future<GeoFirePoint> currentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    GeoFirePoint res = GeoFirePoint(position.latitude,position.longitude);
    return res;
  }

  Future<String> getAddress() async {
    Position position = await Geolocator.getCurrentPosition();

    // Uncomment to submit request to google directly

    // var url = Uri.parse((endpoint + '${position.latitude}'+ ',' + '${position.longitude}'+ '&key=' + apiKey));
    // var response = await http.post(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');


    // Uncomment to use geocoder package

    final coordinates = new GeoC.Coordinates(
        position.latitude, position.longitude);
    var address = await GeoC.Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    return address.first.addressLine;

    // Uncomment to use geocoding package

    // List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // Map<String, dynamic> placemarkMap = placemarks[0].toJson();
    // print(placemarkMap);
    // String address = placemarkMap['name'] + ', '+ placemarkMap['street'] + ', '+ placemarkMap['postalCode'];
    // print(address);
    // return address;
  }

  double calcDistance() {

  }

}