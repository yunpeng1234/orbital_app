import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/widgets/scrolling_location_cards_view_model.dart';
import 'location_card.dart';
import 'scrolling_cards_layout.dart';
import 'package:orbital_app/models/my_location.dart';

class ScrollingLocationCards extends StatefulWidget {

  ScrollingLocationCards({
    Key key,
  }) : super(key: key);

  @override
  _ScrollingLocationCardsState createState() => _ScrollingLocationCardsState();
}

class _ScrollingLocationCardsState extends State<ScrollingLocationCards> {
  final int _maxItems = 10;
  final int toLoad = 5;
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ScrollingLocationCardsViewModel>(
      onModelReady: (model) => model.init(_controller, toLoad),
      builder: (context, model, child) {
        if (model.isBusy()) {
          return ScrollingCardsLayout(
            isLoading: true,
            title: 'Locations',
          );
        }
        return ScrollingCardsLayout(
          isLoading: false,
          isEmpty: model.locations.isEmpty,
          title: 'Locations',
          noDataText: 'No locations to show!',
          widgetList: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.locations.length + 1,
            itemBuilder: (context, index) {
              if (index >= _maxItems) {
                return null;
              }
              if (index == model.locations.length) {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                );
              }
              return LocationCard(
                location: model.locations[index],
                onCardTapped: () => model.navigate('location', arguments: model.locations[index]),
              );
            },
            controller: _controller,
          ),
        );
        }
    );
  }

  List<LocationCard> _buildCardList(ScrollingLocationCardsViewModel model) {
    return model.locations
      .map((location) => LocationCard(
        location: location,
        onCardTapped: () => model.navigate('location', arguments: location)))
        .toList();
  }
}