import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/services/dummy_database.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/services/google_places_service.dart';

class HomeViewModel extends BaseViewModel {
  final DummyDatabase _dummy = serviceLocator<DummyDatabase>();
  final GooglePlacesService _service = serviceLocator<GooglePlacesService>();
  List<DummyLocation> dummyLocations;
  List<MyLocation> locations;
  List<Order> orders;

  Future _getSomeLocations() async {
    dummyLocations = await runBusyFuture(_dummy.getSomeLocations());
  }

  Future getNearbyLocations() async {
    locations = await runBusyFuture(_service.getNearbyLocations());
  }

  Future _getNearbyOrders() async {
  }

  Future init() async {
    getNearbyLocations();
    _getNearbyOrders();
  }
}