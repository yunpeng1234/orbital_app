import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_order_cards_view_model.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';
import 'location_card.dart';

class ScrollingOrderCards extends StatelessWidget {
  const ScrollingOrderCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ScrollingOrderCardsViewModel>(
      onModelReady: (model) => model.getNearbyOrders(),
      builder: (context, model, child) => model.state == ViewState.busy
        ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        )
        : StreamBuilder(
            stream: model.orders,
            builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) {
              print(snapshot);
              print(snapshot.hasData);
              print(snapshot.data);
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              );
            }
            return Container(
              height: 200,
              child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data
                        .map((order) => OrderCard(
                        order: order,
                        onCardTapped: () => model.navigate('order', arguments: order)))
                        .toList()
              ),
            );
        }
      )
    );
  }
}