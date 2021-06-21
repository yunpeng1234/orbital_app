import 'package:orbital_app/services/geolocation_service.dart';

import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/database.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationViewModel extends BaseViewModel {
  final TextEditingController _orderController = new TextEditingController();
  final TextEditingController _commentsController = new TextEditingController();
  final TextEditingController _detailsController = new TextEditingController();
  final DatabaseService _database = serviceLocator<DatabaseService>();
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  final geo = Geoflutterfire();
  GeoFirePoint userLocation;
  String userLocationAddress;

  void setOrder(String order) {
    _orderController.text = order;
  }

  void setComments(String comments) {
    _commentsController.text = comments;
  }

  void setDetails(String details) {
    _detailsController.text = details;
  }

  Future _showSuccessDialog(BuildContext context, LocationViewModel model) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>  AlertDialog(
          title: Center(child: const Text('Successfully submitted!')),
          titleTextStyle: blackBodyTextLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () => model.navigateToHome(),
                child: const Text(
                  'RETURN TO HOME',
                  style: brownButtonText,
                ),
              ),
            )
          ],
        )
    );
  }

  Future submitOrder(
      GlobalKey<FormState> formKey,
      BuildContext context,
      MyLocation restaurant,
      ) async {

    if (! processForm(formKey)) {
      return;
    }
    try {
      var order = await runBusyFuture(
          _database.createOrderData(userLocation, GeoFirePoint(restaurant.lat, restaurant.long),
          _orderController.text, _commentsController.text, restaurant.name, restaurant.address,
          userLocationAddress, _detailsController.text));
      _showSuccessDialog(context, this);
      return order;
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  Future navigateToHome() async {
    navState.pushReplacementNamed('/');
  }

  GeoFirePoint _converter(LocationResult result) {
    return GeoFirePoint(result.latLng.latitude, result.latLng.longitude);
  }

  void showPlacePicker() async {
    // LocationResult result = await navState.pushNamed('placePicker');
    LocationResult result = await navState.push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(dotenv.env['PLACES_KEY'])));
    userLocation = _converter(result);
    userLocationAddress = result.formattedAddress;
    notifyListeners();
  }

  Future getCurrentPosition() async {
    userLocation = await runBusyFuture(_geolocator.currentPosition());
    userLocationAddress = await runBusyFuture(_geolocator.getAddress());
    notifyListeners();
  }
}