import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/all_locations_view_model.dart';

class AllLocationsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<AllLocationsViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: primaryColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: true,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'All Locations',
            style: titleText,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {},
            )
          ],
        ),
      )
    );
  }
}