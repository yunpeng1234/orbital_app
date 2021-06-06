import 'base_view_model.dart';
import 'package:orbital_app/routes/nav_key.dart';

class AllLocationsViewModel extends BaseViewModel {

  Future navigateToAllLocations() async {
    await navState.pushNamed('allLocations');
  }

  Future navigateToCreateAccount() async {
    await NavKey.navKey.currentState.pushNamed('createAccount');
  }

}