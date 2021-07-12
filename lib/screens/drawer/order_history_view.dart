import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/widgets/location_search_result.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/home/search_results_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';

class OrderHistoryView extends StatelessWidget {
  final OrderService _service = serviceLocator<OrderService>();

  OrderHistoryView({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _service.userHistory(),
        builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) { return Loading();}
          return Scaffold(
              appBar: AppBar(),
              drawer: AppDrawer(),
              body: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildCardList(snapshot, context),
              ),
          );
        }
    );
  }

  List<Widget> _buildCardList(AsyncSnapshot<List<Order>> snapshot, BuildContext context) {
    return snapshot.data
        .map((order) => OrderCard(
        order: order,
        onCardTapped: () => Navigator.pushNamed(context, 'myOrders', arguments: order)))
        .toList();
  }
}