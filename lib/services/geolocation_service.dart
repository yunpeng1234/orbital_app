import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as GeoC;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GeolocationService {
  final String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  final String apiKey = dotenv.env['PLACES_KEY'];
  static final Stream<Position> _positionStream = Geolocator.getPositionStream(distanceFilter: 500);
  static Position position;

  Future init() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    _positionStream.listen((event) {
      position = event;
    });
    await initPosition();
  }

  Future initPosition() async {
    position = await _positionStream.first;
  }

  GeoFirePoint currentPosition()  {
    GeoFirePoint res = GeoFirePoint(position.latitude,position.longitude);
    return res;
  }

  void listenToPosition(void Function(Position) callback) {
    _positionStream.listen(callback);
  }

  Future<String> getAddress() async {
    final coordinates = new GeoC.Coordinates(
        position.latitude, position.longitude);
    var address = await GeoC.Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    return address.first.addressLine;
  }

}