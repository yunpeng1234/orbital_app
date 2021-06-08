import 'package:orbital_app/services/database.dart';
import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/models/location.dart';
import 'package:orbital_app/routes/nav_key.dart';

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
  Future submitOrder() async {
    var order = await runBusyFuture(_database.createOrderData(_orderController.text));
  }

  Future navigateToHome() async {
    navState.pushReplacementNamed('/');
  }
}