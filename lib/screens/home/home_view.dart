import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/shared/widgets/scrollingmyorder.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import "package:provider/provider.dart";
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/widgets/floating_search_bar.dart';
import 'package:orbital_app/shared/widgets/order_card.dart';
import 'package:orbital_app/shared/widgets/scrolling_location_cards.dart';
import 'package:orbital_app/shared/widgets/scrollingtakenorder.dart';
import 'package:orbital_app/shared/widgets/scrolling_order_cards.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/home/home_view_model.dart';
import 'package:orbital_app/screens/authenticate/signin_view.dart';
class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Individual>(context) == null) {
      return SignInView();
    }

    return BaseView<HomeViewModel>(
      builder: (context, model, child) => model.state == ViewState.busy
        ? Center(child: Loading())
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
                  child: ListView(
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
                          // Column(
                          //   children: [
                          //     verticalSpaceTiny,
                          //     GestureDetector(
                          //       onTap: () async {
                          //         model.navigate('allLocations');
                          //       },
                          //       child: Text(
                          //         'See More',
                          //         style: brownButtonText.copyWith(
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      ScrollingLocationCards(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Orders',
                            style: titleText,
                          ),
                          // Jank way of making the 'See All' look like its centered
                          // to the other text
                          // Column(
                          //   children: [
                          //     verticalSpaceTiny,
                          //     GestureDetector(
                          //       onTap: () => model.showPlacePicker(),
                          //       child: Text(
                          //         'Filter Orders',
                          //         style: brownButtonText.copyWith(
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      ScrollingOrderCards(),
                      verticalSpaceRegular,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'My Orders',
                            style: titleText,
                          ),
                        ],
                      ),
                      ScrollingMyOrder(),
                      verticalSpaceRegular,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Taken Jobs',
                            style: titleText,
                          ),
                        ],
                      ),
                      ScrollingTakenOrder(),
                      verticalSpaceRegular,

                    ],
                  ),
                )
              ],
            )
          ),
    );
  }
}


