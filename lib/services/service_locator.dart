import 'package:get_it/get_it.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/orderservice.dart';
import 'package:orbital_app/shared/widgets/scrollingmyorder.dart';
import 'package:orbital_app/view_models/authenticate/signin_view_model.dart';
import 'package:orbital_app/view_models/authenticate/password_reset_view_model.dart';
import 'package:orbital_app/view_models/authenticate/register_view_model.dart';
import 'package:orbital_app/view_models/home/home_view_model.dart';
import 'package:orbital_app/view_models/drawer/app_drawer_view_model.dart';
import 'package:orbital_app/view_models/home/all_locations_view_model.dart';
import 'package:orbital_app/view_models/home/my_order_view_model.dart';
import 'package:orbital_app/view_models/home/order_details_view_model.dart';
import 'package:orbital_app/view_models/home/taken_order_view_model.dart';
import 'package:orbital_app/view_models/submit_order_flow/location_view_model.dart';
import 'package:orbital_app/view_models/submit_order_flow/input_order_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_location_cards_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrollingmyorderviewmodel.dart';
import 'package:orbital_app/view_models/widgets/scrollingtakenorderviewmodel.dart';
import 'package:orbital_app/view_models/widgets/scrolling_order_cards_view_model.dart';
import 'geolocation_service.dart';
import 'database.dart';
import 'auth_service.dart';
import 'google_places_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => AuthService());
  serviceLocator.registerLazySingleton(() => GeolocationService());
  serviceLocator.registerLazySingleton(() => DatabaseService.init());
  serviceLocator.registerLazySingleton(() => GooglePlacesService());
  serviceLocator.registerLazySingleton(() => OrderService.init());
  serviceLocator.registerLazySingleton(() => SignInViewModel());
  serviceLocator.registerLazySingleton(() => RegisterViewModel());
  serviceLocator.registerLazySingleton(() => PasswordResetViewModel());
  serviceLocator.registerLazySingleton(() => AppDrawerViewModel());
  serviceLocator.registerLazySingleton(() => AllLocationsViewModel());
  serviceLocator.registerLazySingleton(() => ScrollingLocationCardsViewModel());
  serviceLocator.registerFactory(() => ScrollingOrderCardsViewModel());
  serviceLocator.registerLazySingleton(() => ScrollingTakenOrderViewModel());
  serviceLocator.registerLazySingleton(() => ScrollingMyOrderViewModel());
  serviceLocator.registerLazySingleton(() => HomeViewModel());
  serviceLocator.registerLazySingleton(() => LocationViewModel());
  serviceLocator.registerLazySingleton(() => TakenOrderViewModel());
  serviceLocator.registerLazySingleton(() => MyOrderViewModel());
  serviceLocator.registerFactory(() => InputOrderViewModel());
  serviceLocator.registerFactory(() => OrderDetailsViewModel());
  
}