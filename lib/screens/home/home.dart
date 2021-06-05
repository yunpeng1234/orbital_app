import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/services/auth_service.dart';
import 'package:orbital_app/services/database.dart';
import 'package:orbital_app/shared/drawer.dart';
import 'package:orbital_app/shared/constants.dart';
import "package:provider/provider.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orbital_app/models/user.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Home extends StatelessWidget {
  
  Widget _buildFloatingSearchBar() {
    // final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: -1.0,
      openAxisAlignment: 0.0,
      width: 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      // transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: primaryColor,
      // This is handled by the search bar itself.
      // appBar: _buildFloatingSearchBar(),
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildFloatingSearchBar(),
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
              ],
            ),
          )
        ],
      )
    );
  }
}