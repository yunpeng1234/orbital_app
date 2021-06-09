import 'package:orbital_app/services/database.dart';
import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/constants.dart';

class InputOrderViewModel extends BaseViewModel {

  final TextEditingController _orderController = new TextEditingController();
  final TextEditingController _notesController = new TextEditingController();
  final DatabaseService _database = serviceLocator<DatabaseService>();
  final bool error = false;


  void setOrder(String order) {
    _orderController.text = order;
  }

  void setNotes(String notes) {
    _notesController.text = notes;
  }

  // Only submitting order data for now (listed as 'item' in database), to possibly include more
  // in the future e.g. location, extra notes
  Future submitOrder(GlobalKey<FormState> formKey, BuildContext context) async {
    if (! processForm(formKey)) {
      return;
    }
    try {
      var order = await runBusyFuture(
          _database.createOrderData(_orderController.text));
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

  Future _showSuccessDialog(BuildContext context, InputOrderViewModel model) {
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
}