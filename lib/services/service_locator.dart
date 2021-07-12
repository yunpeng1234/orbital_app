import 'package:get_it/get_it.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:orbital_app/view_models/authenticate/signin_view_model.dart';
import 'package:orbital_app/view_models/authenticate/password_reset_view_model.dart';
import 'package:orbital_app/view_models/authenticate/register_view_model.dart';
import 'package:orbital_app/view_models/chat/chat_view_model.dart';
import 'package:orbital_app/view_models/chat/contact_page_view_model.dart';
import 'package:orbital_app/view_models/drawer/profile_page_view_model.dart';
import 'package:orbital_app/view_models/drawer/order_history_view_model.dart';
import 'package:orbital_app/view_models/home/home_view_model.dart';
import 'package:orbital_app/view_models/drawer/app_drawer_view_model.dart';
import 'package:orbital_app/view_models/home/my_order_view_model.dart';
import 'package:orbital_app/view_models/home/order_details_view_model.dart';
import 'package:orbital_app/view_models/home/search_results_view_model.dart';
import 'package:orbital_app/view_models/home/taken_order_view_model.dart';
import 'package:orbital_app/view_models/home/location_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_location_cards_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_my_orders_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_taken_orders_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_all_orders_view_model.dart';
import 'package:orbital_app/view_models/widgets/my_search_bar_view_model.dart';
import 'package:orbital_app/view_models/chat/contact_tile_view_model.dart';
import 'geolocation_service.dart';
import 'database.dart';
import 'auth_service.dart';
import 'google_places_service.dart';
import 'message_service.dart';
import 'notification_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => AuthService());

  serviceLocator.registerSingletonAsync(() async {
    final geolocator = GeolocationService();
    await geolocator.init();
    return geolocator;
  });

  serviceLocator.registerLazySingleton(() => DatabaseService());

  serviceLocator.registerSingletonWithDependencies(() => GooglePlacesService(),
      dependsOn: [GeolocationService]);

  serviceLocator.registerSingletonWithDependencies(() => OrderService(),
      dependsOn: [GeolocationService]);

  serviceLocator.registerSingletonAsync(() async {
    await serviceLocator.isReady<OrderService>();
    final notifications = NotificationService();
    await notifications.init();
    return notifications;
  });

  serviceLocator.registerLazySingleton(() => SignInViewModel());

  serviceLocator.registerLazySingleton(() => RegisterViewModel());

  serviceLocator.registerLazySingleton(() => PasswordResetViewModel());

  serviceLocator.registerLazySingleton(() => AppDrawerViewModel());

  serviceLocator.registerLazySingleton(() => ProfilePageViewModel());

  serviceLocator.registerSingletonWithDependencies(() => ScrollingLocationCardsViewModel(),
      dependsOn: [GeolocationService, GooglePlacesService]);

  serviceLocator.registerSingletonWithDependencies(() => ScrollingAllOrdersViewModel(),
      dependsOn: [GeolocationService, OrderService]);

  serviceLocator.registerSingletonWithDependencies(() => ScrollingTakenOrdersViewModel(),
      dependsOn: [OrderService]);

  serviceLocator.registerSingletonWithDependencies(() => ScrollingMyOrdersViewModel(),
      dependsOn: [OrderService]);

  serviceLocator.registerLazySingleton(() => HomeViewModel());

  serviceLocator.registerSingletonWithDependencies(() => LocationViewModel(),
      dependsOn: [GeolocationService, OrderService]);

  serviceLocator.registerLazySingleton(() => TakenOrderViewModel());

  serviceLocator.registerLazySingleton(() => MyOrderViewModel());

  serviceLocator.registerSingletonWithDependencies(() => MySearchBarViewModel(),
      dependsOn: [GooglePlacesService]);

  serviceLocator.registerSingletonWithDependencies(() => SearchResultsViewModel(),
      dependsOn: [GooglePlacesService]);

  serviceLocator.registerFactory(() => OrderDetailsViewModel());

  serviceLocator.registerLazySingleton(() => ContactPageViewModel());
  
  serviceLocator.registerLazySingleton(() => MessageService());

  serviceLocator.registerLazySingleton(() => ContactTileViewModel());

  serviceLocator.registerLazySingleton(() => ChatViewModel());

  serviceLocator.registerLazySingleton(() => OrderHistoryViewModel());
}