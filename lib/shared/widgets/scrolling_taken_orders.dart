import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/widgets/scrolling_taken_orders_view_model.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';
import 'scrolling_cards_layout.dart';

class ScrollingTakenOrders extends StatelessWidget {

  ScrollingTakenOrders({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ScrollingTakenOrdersViewModel>(
        onModelReady: (model) => model.init(),
        builder: (context, model, child) => StreamBuilder(
            stream: model.orders,
            builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
              if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) {
                return ScrollingCardsLayout(
                  isLoading: true,
                  title: 'Taken Orders',
                );
              }
              return ScrollingCardsLayout(
                isLoading: false,
                isEmpty: snapshot.data.isEmpty,
                title: 'Taken Orders',
                noDataText: 'You haven\'t taken any orders!',
                widgetList: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buildCardList(snapshot, model),
                ),
              );
            }
        )
    );
  }

  List<Widget> _buildCardList(AsyncSnapshot<List<Order>> snapshot, ScrollingTakenOrdersViewModel model) {
    return snapshot.data
        .map((order) => OrderCard(
        order: order,
        onCardTapped: () => model.navigate('takenOrders', arguments: order)))
        .toList();
  }
}