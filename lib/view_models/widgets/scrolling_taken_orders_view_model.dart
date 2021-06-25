import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/order_service.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'dart:async';

class ScrollingTakenOrdersViewModel extends BaseViewModel {

  final OrderService _database = serviceLocator<OrderService>();
  Stream<List<Order>> orders;

  void init() {
    _getNearbyOrdersTo();
  }

  void _getNearbyOrdersTo() {
    orders = _database.filterByTo();
  }
}