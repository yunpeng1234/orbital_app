import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/widgets/order_history.dart';
import 'package:orbital_app/view_models/drawer/order_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/models/order.dart';

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
            appBar: AppBar(title: Text('Order History', style: titleText)),
            drawer: AppDrawer(),
            body: snapshot.data.isEmpty
                ? Center(
                  child: Text(
                  'You have no orders yet.',
                  style: subtitleText,
                  textAlign: TextAlign.center,
                  ),
                )
                : Column(
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
        .map((order) => OrderTile(info : order))
        .toList();
  }
}