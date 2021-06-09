import 'package:orbital_app/services/dummy_database.dart';
import '../base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/location.dart';

class HomeViewModel extends BaseViewModel {
  final DummyDatabase dummy = serviceLocator<DummyDatabase>();
  List<Location> locations;

  Future getSomeLocations() async {
    locations = await runBusyFuture(dummy.getSomeLocations());
  }
}