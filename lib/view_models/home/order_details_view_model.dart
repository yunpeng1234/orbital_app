import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OrderDetailsViewModel extends BaseViewModel {
  final OrderService _database = serviceLocator<OrderService>();

  Future _showSuccessDialog(BuildContext context, OrderDetailsViewModel model) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>  AlertDialog(
          title: Center(child: const Text('Order taken!')),
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

  Future takeOrder(BuildContext context, int orderId) async {
    await runBusyFuture(_database.acceptOrderData(orderId));
    _showSuccessDialog(context, this);
  }

  Future navigateToHome() async {
    navState.pushReplacementNamed('/');
  }
}