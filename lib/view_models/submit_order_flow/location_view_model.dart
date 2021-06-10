import '../base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/models/my_location.dart';

class LocationViewModel extends BaseViewModel {
  final TextEditingController orderController = new TextEditingController();
  final TextEditingController notesController = new TextEditingController();

  Future navigateToInputOrder(MyLocation location) async {
    await navState.pushNamed('inputOrder', arguments: location);
  }

  void setOrder(String order) {
    orderController.text = order;
    notifyListeners();
  }
}