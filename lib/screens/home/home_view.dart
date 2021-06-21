import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/shared/widgets/scrolling_my_order.dart';
import 'package:orbital_app/view_models/base_view_model.dart';
import "package:provider/provider.dart";
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/widgets/floating_search_bar.dart';
import 'package:orbital_app/shared/widgets/scrolling_location_cards.dart';
import 'package:orbital_app/shared/widgets/scrolling_taken_orders.dart';
import 'package:orbital_app/shared/widgets/scrolling_all_orders.dart';
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
                      verticalSpaceLarge,
                      ScrollingLocationCards(),
                      ScrollingAllOrders(),
                      verticalSpaceRegular,
                      ScrollingMyOrders(),
                      verticalSpaceRegular,
                      ScrollingTakenOrders(),
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


