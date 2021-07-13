import 'package:orbital_app/services/order_service.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/models/order.dart';

class OrderHistoryViewModel extends BaseViewModel {
  final OrderService _database  = serviceLocator<OrderService>();
  Stream<List<Order>> orders;

  Future init() async{
    orders = _database.userHistory();
  }
  
}