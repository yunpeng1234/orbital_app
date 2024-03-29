import 'package:orbital_app/shared/widgets/popup_text.dart';

import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/order_service.dart';
import 'dart:async';

class MyOrderViewModel extends BaseViewModel {
  final OrderService _database = serviceLocator<OrderService>();

  Future _showSuccessDialog(BuildContext context, MyOrderViewModel model, String message) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>  AlertDialog(
          title: Center(child: Text(message)),
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

  Future cancelOrder(BuildContext context, int orderId) async {
    await runBusyFuture(_database.deleteOrderData(orderId));
    _showSuccessDialog(context, this, 'Order cancelled!');
  }

  Future completeOrder(BuildContext context, int orderId) async {
    await runBusyFuture(_database.moveOrder(orderId));
    _showSuccessDialog(context, this, 'Order completed!');
  }

  Future navigateToHome() async {
    navKey.currentState.pop();
    navKey.currentState.pop();
  }

  Future popupDialog (BuildContext context, int orderId) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:(BuildContext context) => PopUpText(
        text: 'Confirm',
        message: 'Please check that the order is correct before confirming delivery',
        onTapYes: completeOrder(context, orderId),
        onTapNo: cancelOrder(context,orderId)
      )
    );
  }
}