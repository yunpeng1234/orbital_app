import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:place_picker/place_picker.dart';
import 'package:orbital_app/shared/widgets/scrolling_all_orders.dart';



class ScrollingMyOrdersViewModel extends BaseViewModel {

  final OrderService _database = serviceLocator<OrderService>();
  Stream<List<Order>> orders;

  Future init() {
    _getNearbyOrdersFrom();
  }

  void _getNearbyOrdersFrom() {
    orders = _database.filterByFrom();
  }
}