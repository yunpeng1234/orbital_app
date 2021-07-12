import 'package:orbital_app/screens/drawer/order_view_history.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/widgets/location_search_result.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/view_models/drawer/order_history_view_model.dart';
import 'package:orbital_app/view_models/home/search_results_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/order_service.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';

class OrderHistoryView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderHistoryViewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => StreamBuilder(
          stream: model.orders,
          builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) { return Loading();}
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(),
            drawer: AppDrawer(),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: _buildCardList(snapshot, context),
                  ),
                ),
              ]
            ),
          );
        } 
      )
    );
  }

  List<Widget> _buildCardList(AsyncSnapshot<List<Order>> snapshot, BuildContext context) {
    return snapshot.data
        .map((order) => Container(
          width: 300,
          height: 50,
          child: ListTile(
            title: Text(order.orderId.toString()),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryPopUp(order: order)))),
        ))
        .toList();
  }
}