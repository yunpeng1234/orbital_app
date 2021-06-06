import 'package:orbital_app/services/dummy_database.dart';
import 'base_view_model.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/models/location.dart';
import 'package:orbital_app/routes/nav_key.dart';

class HomeViewModel extends BaseViewModel {
  final DummyDatabase dummy = serviceLocator<DummyDatabase>();
  List<Location> locations;

  Future navigateToAllLocations() async {
    await navState.pushNamed('allLocations');
  }

  Future getSomeLocations() async {
    setState(ViewState.busy);
    locations = await dummy.getSomeLocations();
    setState(ViewState.idle);
  }
}