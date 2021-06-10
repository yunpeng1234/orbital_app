import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/order.dart';

class OrderHomeScreenCard extends StatelessWidget {
  final Order order;
  final Function onCardTapped;

  const OrderHomeScreenCard({
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
          child: Column(
            children: <Widget>[
              Text(
                'From: ${order.from}',
                style: blackBodyText,
              ),
              verticalSpaceRegular,
              Text(
                'From: ${order.orderId}',
                style: blackBodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}