import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/shared/app_drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import "package:provider/provider.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/user.dart';
import 'package:orbital_app/shared/widgets/floating_search_bar.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/home_view_model.dart';
import 'package:orbital_app/screens/authenticate/signin_view.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Individual>(context) == null) {
      return SignInView();
    }

    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
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
                children: [
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
                              model.navigateToAllLocations();
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
                  // verticalSpaceMassive, // Replace with location cards in future
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 180,
                          child: Card(
                            margin: EdgeInsets.all(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  height: 140,
                                  child: Image(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      'https://d1nqx6es26drid.cloudfront.net/app/uploads/2015/06/03172655/default_tile_logo_mcd_red.png',
                                    ),
                                  ),
                                ),
                                Text('McDonalds'),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'Card with Beveled border',
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            'Card with Beveled border',
                          ),
                        ),
                      ],
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
                  verticalSpaceMassive, // Replace with location cards in future
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}