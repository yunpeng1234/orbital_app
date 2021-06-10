import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/submit_order_flow/location_view_model.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/services/google_places_service.dart';

class LocationView extends StatelessWidget {
  final DummyLocation location;

  const LocationView({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LocationViewModel>(
        builder: (context, model, child) =>
            Scaffold(
              backgroundColor: primaryColor,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  location.title,
                  style: titleText,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: GestureDetector(
                    onTap: () => model.navigateToInputOrder(location),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: greyButtonColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: model.isBusy()
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                          : Text(
                        'Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
    );
  }
}
