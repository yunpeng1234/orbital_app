import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/home/order_details_view_model.dart';

class OrderDetailsView extends StatelessWidget {
  final Order order;

  const OrderDetailsView({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderDetailsViewModel>(
      onModelReady: (model) => model.init(order),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'From: ${order.fromName}',
                  style: blackBodyText,
                ),
                verticalSpaceRegular,
                Text(
                  'Order ID: ${order.orderId}',
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
                GestureDetector(
                  onTap: () => model.takeOrder(context, order.orderId),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: greyButtonColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: model.isBusy()
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                        : Text(
                      'Take Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}