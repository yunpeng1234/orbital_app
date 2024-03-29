import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/home/my_order_view_model.dart';

class MyOrderView extends StatelessWidget {
  final Order order;

  const MyOrderView({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MyOrderViewModel>(
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
                verticalSpaceRegular,
                if (order.to != '') Text(
                  'Order taken by: ${order.toName}',
                  style: blackBodyText,
                ),
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
                if (order.done)  GestureDetector(
                  onTap: () => model.completeOrder(context, order.orderId),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: model.isBusy()
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                        : Text(
                      'Complete',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                verticalSpaceRegular,
                if (order.to == '') GestureDetector(
                  onTap: () => model.cancelOrder(context, order.orderId),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: model.isBusy()
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                        : Text(
                      'Cancel Order',
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