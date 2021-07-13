import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/shared/constants.dart';

class OrderHistoryPopUp extends StatelessWidget {
  final Order order;

  const OrderHistoryPopUp({
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpaceRegular,
                Text(
                  'Order taken by: ${order.toName}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                'From: ${order.fromName}',
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
                  'Deliver To: ${order.deliverToAddress}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Address Details: ${order.newAddressDetails()}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Order: ${order.order}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Comments: ${order.newComment()}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Fee: \$${order.fee}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
              ],
            ),
          ),
        );
  }
}