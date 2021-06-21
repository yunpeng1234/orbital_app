import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/widgets/scrolling_location_cards_view_model.dart';
import 'location_card.dart';
import 'scrolling_cards_layout.dart';
import 'package:orbital_app/models/my_location.dart';

class ScrollingLocationCards extends StatelessWidget {
  const ScrollingLocationCards({
    Key key,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return BaseView<ScrollingLocationCardsViewModel>(
  //       onModelReady: (model) => model.init(),
  //       builder: (context, model, child) =>  model.isBusy()
  //         ? CircularProgressIndicator(
  //           valueColor: AlwaysStoppedAnimation(Colors.white),
  //         )
  //         : Container(
  //           height: 200,
  //           child: ListView(
  //             scrollDirection: Axis.horizontal,
  //             children: model.locations
  //               .map((location) =>
  //               LocationCard(
  //                 location: location,
  //                 onCardTapped: () =>
  //                   model.navigate(
  //                     'location', arguments: location)))
  //                   .toList()
  //               ),
  //             )
  //           );
  // }

  @override
  Widget build(BuildContext context) {
    return BaseView<ScrollingLocationCardsViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => FutureBuilder(
        future: model.locations,
        builder:(BuildContext context, AsyncSnapshot<List<MyLocation>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done || ! snapshot.hasData) {
            return ScrollingCardsLayout(
              isLoading: true,
              isEmpty: false,
              title: 'Locations',
            );
          }
        return ScrollingCardsLayout(
          isLoading: false,
          isEmpty: snapshot.data.isEmpty,
          title: 'Locations',
          noDataText: 'No locations to show!',
          widgetList: _buildCardList(snapshot, model),
        );
        }
    )
    );
  }

  List<LocationCard> _buildCardList( AsyncSnapshot<List<MyLocation>> snapshot, ScrollingLocationCardsViewModel model) {
    return snapshot.data
      .map((location) => LocationCard(
        location: location,
        onCardTapped: () => model.navigate('location', arguments: location)))
        .toList();
  }
}