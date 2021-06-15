import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/order_view_model.dart';

class OrderView extends StatelessWidget {
  final Order order;

  const OrderView({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Order Details',
              style: titleText,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                Text(
                'From: ${order.from}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'ID: ${order.orderId}',
                    style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Restaurant Name: ${order.restaurantName}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Restaurant Address: ${order.restaurantAddress}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Deliver To: ${order.deliverTo}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Order: ${order.order}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                    'Comments: ${order.comments}',
                  style: blackBodyText,
                ),
              ],
            ),
          ),
        )
    );
  }
}