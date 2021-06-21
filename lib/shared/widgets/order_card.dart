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
    // if(order.done) {
    //   return Container(
    //     width: 180,
    //     height: 140,
    //     color: Colors.green,
    //   );
    // }

    return Container(
      
      width: 180,
      height: 140,
      child: GestureDetector(
        onTap: onCardTapped,
        child: Card(
          margin: EdgeInsets.all(10),
          color: !order.done ? Colors.white : Colors.green,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(
              children: <Widget>[
                Text(
                  'Restaurant: ${order.restaurantName}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'Deliver To: ${order.deliverToAddress}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'Order: ${order.order}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'From: ${order.fromName}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'Id: ${order.toName}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,
                Text(
                  'Id: ${order.orderId}',
                  style: blackBodyText,
                ),
                verticalSpaceTiny,

              ],
            ),
          ),
        ),
      ),
    );
  }
}