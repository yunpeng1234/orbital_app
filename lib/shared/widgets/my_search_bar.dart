import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/shared/widgets/prediction_card.dart';
import 'package:orbital_app/view_models/widgets/my_search_bar_view_model.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MySearchBar extends StatelessWidget {
  final FloatingSearchBarController controller = FloatingSearchBarController();
  MySearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<MySearchBarViewModel>(
      onModelReady: (model) => model.init(controller),
      builder: (context, model, child) => FloatingSearchBar(
        hint: 'Search...',
        backgroundColor: Colors.white60,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: -1.0,
        openAxisAlignment: 0.0,
        width: 500,
        debounceDelay: const Duration(milliseconds: 500),
        controller: controller,
        onQueryChanged: (query) {
          model.getAutocomplete(query);
        },
        onSubmitted: (query) => model.navigate('searchResults', arguments: query),
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        // transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: model.isBusy()
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black)
                      ),
                    ),
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: model.predictions
                    // .map((prediction) => Text(prediction, style: blackBodyText,)).toList()
                      .map((prediction) => PredictionCard(info: prediction, onCardTapped: () {
                        model.navigateToLocation(prediction);
                      })).toList()
            ),
          ));
        },
      ),
    );
  }
}
