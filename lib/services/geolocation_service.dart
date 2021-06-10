import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; //Geocoding package is iffy, gonna try google geocoding now
import 'package:geocoder/geocoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class GeolocationService {
  String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  String apiKey = dotenv.env['PLACES_KEY'];

  Future _currentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future getAddress() async {
    Position position = await _currentPosition();

    // Uncomment to submit request to google directly

    // var url = Uri.parse((endpoint + '${position.latitude}'+ ',' + '${position.longitude}'+ '&key=' + apiKey));
    // var response = await http.post(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');


    // Uncomment to use geocoder package

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(address);
    print("${address.first.featureName} : ${address.first.addressLine}");
    return address.first.addressLine;

    // Uncomment to use geocoding package

    // List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // Map<String, dynamic> placemarkMap = placemarks[0].toJson();
    // print(placemarkMap);
    // String address = placemarkMap['name'] + ', '+ placemarkMap['street'] + ', '+ placemarkMap['postalCode'];
    // print(address);
    // return address;
  }
}