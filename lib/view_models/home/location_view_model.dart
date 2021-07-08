import 'package:orbital_app/services/geolocation_service.dart';

import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationViewModel extends BaseViewModel {
  final TextEditingController _orderController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final OrderService _database = serviceLocator<OrderService>();
  final GeolocationService _geolocator = serviceLocator<GeolocationService>();
  GeoFirePoint deliveryLocation;
  String deliveryLocationAddress;

  void setOrder(String order) {
    _orderController.text = order;
  }

  void setFee(String fee) {
    _feeController.text = fee;
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
          _database.createOrderData(deliveryLocation, GeoFirePoint(restaurant.lat, restaurant.long),
          _orderController.text, _commentsController.text, restaurant.name, restaurant.address,
          deliveryLocationAddress, _detailsController.text, _feeController.text));
      _showSuccessDialog(context, this);
      return order;
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  Future navigateToHome() async {
    navKey.currentState.pop();
    navKey.currentState.pop();
  }

  GeoFirePoint _converter(LocationResult result) {
    return GeoFirePoint(result.latLng.latitude, result.latLng.longitude);
  }

  void showPlacePicker() async {
    // LocationResult result = await navState.pushNamed('placePicker');
    LocationResult result = await navKey.currentState.push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(dotenv.env['PLACES_KEY'])));
    deliveryLocation = _converter(result);
    deliveryLocationAddress = result.formattedAddress;
    notifyListeners();
  }

  Future getCurrentPosition() async {
    deliveryLocation = _geolocator.currentPosition();
    deliveryLocationAddress = await runBusyFuture(_geolocator.getAddress());
    notifyListeners();
  }
}