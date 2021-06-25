import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/order_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';

class ScrollingMyOrdersViewModel extends BaseViewModel {

  final OrderService _database = serviceLocator<OrderService>();
  Stream<List<Order>> orders;

  void init() {
    _getNearbyOrdersFrom();
  }

  void _getNearbyOrdersFrom() {
    orders = _database.filterByFrom();
  }
}