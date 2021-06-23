import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/shared/widgets/iconword.dart';

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
          color: !order.done ? Colors.white : Colors.green,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconText(icon:Icons.local_restaurant, text: order.restaurantName ),
                verticalSpaceTiny,
                IconText(icon: Icons.location_on, text: order.deliverToAddress),
                verticalSpaceTiny,
                IconText(icon: Icons.dinner_dining, text: order.order),
                verticalSpaceTiny,
              ],
            ),
          ),
        ),
      ),
    );
  }
}