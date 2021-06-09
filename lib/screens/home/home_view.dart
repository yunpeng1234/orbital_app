import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import "package:provider/provider.dart";
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/widgets/floating_search_bar.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/home/home_view_model.dart';
import 'package:orbital_app/screens/authenticate/signin_view.dart';
import 'package:orbital_app/shared/widgets/home_screen_card.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Individual>(context) == null) {
      return SignInView();
    }

    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.getSomeLocations(),
      builder: (context, model, child) => model.state == ViewState.busy
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            drawer: AppDrawer(),
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                buildFloatingSearchBar(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      verticalSpaceVeryLarge,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Locations',
                            style: titleText,
                          ),
                          // Jank way of making the 'See All' look like its centered
                          // to the other text
                          Column(
                            children: [
                              verticalSpaceTiny,
                              GestureDetector(
                                onTap: () async {
                                  model.navigate('allLocations');
                                },
                                child: Text(
                                  'See All',
                                  style: brownButtonText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: model.locations
                            .map((location) => HomeScreenCard(
                              location: location,
                              onCardTapped: () => model.navigate('location', arguments: location)))
                            .toList()
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Orders',
                            style: titleText,
                          ),
                          // Jank way of making the 'See All' look like its centered
                          // to the other text
                          Column(
                            children: [
                              verticalSpaceTiny,
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'See All',
                                  style: brownButtonText.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children : model.locations
                              .map((location) => HomeScreenCard(
                                location: location,
                                onCardTapped: () => model.navigate('order')))
                              .toList()
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
    );
  }
}

