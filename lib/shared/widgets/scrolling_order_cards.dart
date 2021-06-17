import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import 'package:orbital_app/view_models/widgets/scrolling_order_cards_view_model.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'dart:async';


class ScrollingOrderCards extends StatefulWidget {

  const ScrollingOrderCards({
    Key key,
  }) : super(key: key);

  @override
  _ScrollingOrderCardsState createState() => _ScrollingOrderCardsState();
}

class _ScrollingOrderCardsState extends State<ScrollingOrderCards> {

  @override
  Widget build(BuildContext context) {
    return BaseView<ScrollingOrderCardsViewModel>(
      onModelReady: (model) => model.getCurrentPosition(),
      builder: (context, model, child) => StreamBuilder(
            stream: model.orders,
            builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              );
            } else if (snapshot.data.isEmpty) {
              return Column(
                children: [
                  verticalSpaceRegular,
                  Text(
                    'No orders in your area! :(',
                    style: titleText,
                  ),
                ],
              );
            }
            return Column(
              children: [
                Container(
                  height: 200,
                  child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data
                            .map((order) => OrderCard(
                            order: order,
                            onCardTapped: () => model.navigate('order', arguments: order)))
                            .toList()
                  ),
                ),
                verticalSpaceRegular,
                GestureDetector(
                  onTap: () => model.showPlacePicker(),
                  child: Text(
                    'Filter Orders',
                    style: brownButtonText.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
        }
      )
    );
  }
}