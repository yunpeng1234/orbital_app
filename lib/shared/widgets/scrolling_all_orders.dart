import 'package:flutter/material.dart';
import 'package:orbital_app/models/order.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'scrolling_cards_layout.dart';
import 'package:orbital_app/view_models/widgets/scrolling_all_orders_view_model.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';

class ScrollingAllOrders extends StatelessWidget {

  ScrollingAllOrders({
    Key key,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return BaseView<ScrollingOrderCardsViewModel>(
  //       onModelReady: (model) => model.init(),
  //       builder: (context, model, child) => StreamBuilder(
  //           stream: model.orders,
  //           builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
  //             if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) {
  //               return CircularProgressIndicator(
  //                 valueColor: AlwaysStoppedAnimation(Colors.white),
  //               );
  //             } else if (snapshot.data.isEmpty) {
  //               return Column(
  //                 children: [
  //                   verticalSpaceRegular,
  //                   Text(
  //                     'No orders in your area! :(',
  //                     style: titleText,
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   verticalSpaceRegular,
  //                   GestureDetector(
  //                     onTap: () => model.showPlacePicker(),
  //                     child: Text(
  //                       'Filter Orders',
  //                       style: brownButtonText.copyWith(
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }
  //             return Column(
  //               children: [
  //                 Container(
  //                   height: 200,
  //                   child: ListView(
  //                       scrollDirection: Axis.horizontal,
  //                       children: snapshot.data
  //                           .map((order) => OrderCard(
  //                           order: order,
  //                           onCardTapped: () => model.navigate('order', arguments: order)))
  //                           .toList()
  //                   ),
  //                 ),
  //                 verticalSpaceRegular,
  //                 GestureDetector(
  //                   onTap: () => model.showPlacePicker(),
  //                   child: Text(
  //                     'Filter Orders',
  //                     style: brownButtonText.copyWith(
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //
  //               ],
  //             );
  //           }
  //       )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BaseView<ScrollingAllOrdersViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => StreamBuilder(
        stream: model.orders,
        builder:(BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.connectionState != ConnectionState.active || ! snapshot.hasData) {
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          );
        }
        return ScrollingCardsLayout(
          isEmpty: snapshot.data.isEmpty,
          title: 'All Orders',
          sideButtonText: 'Filter Orders',
          noDataText: 'No orders in your area! :(',
          widgetList: _buildCardList(snapshot, model),
          onSideButtonTapped: () => model.showPlacePicker(),
        );
        }
      )
    );
  }

  List<Widget> _buildCardList(AsyncSnapshot<List<Order>> snapshot, ScrollingAllOrdersViewModel model) {
    return snapshot.data
      .map((order) => OrderCard(
      order: order,
      onCardTapped: () => model.navigate('order', arguments: order)))
    .toList();
  }
}