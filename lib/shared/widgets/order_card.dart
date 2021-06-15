import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/order.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function onCardTapped;

  const OrderCard({
    this.order,
    this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 140,
      child: GestureDetector(
        onTap: onCardTapped,
        child: Card(
          margin: EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'From: ${order.from}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'Id: ${order.orderId}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'Name: ${order.restaurantName}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}