import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/models/location.dart';

class LocationViewModel extends BaseViewModel {
  final TextEditingController orderController = new TextEditingController();
  final TextEditingController notesController = new TextEditingController();

  Future navigateToInputOrder(Location location) async {
    await navState.pushNamed('inputOrder', arguments: location);
  }

  void setOrder(String order) {
    orderController.text = order;
    notifyListeners();
  }
}