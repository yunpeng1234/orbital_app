import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/submit_order_flow/location_view_model.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/models/dummy_location.dart';
import 'package:orbital_app/services/google_places_service.dart';

class LocationView extends StatelessWidget {
  final MyLocation location;
  final _formKey = GlobalKey<FormState>();

  LocationView({
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
                  location.name,
                  style: titleText,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        location.name,
                        style: blackBodyText,
                      ),
                      verticalSpaceRegular,
                      Text(
                        location.address,
                        style: blackBodyText,
                      ),
                      verticalSpaceLarge,
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              minLines: 1,
                              maxLines: null,
                              decoration: textBoxDeco.copyWith(
                                  hintText: 'Enter your order!'
                              ),
                              onSaved: (val) {
                                model.setOrder(val);
                              },
                              validator: (val) => val.isEmpty ? 'Please enter your order.' : null,
                            ),
                            verticalSpaceRegular,
                            TextFormField(
                                minLines: 1,
                                maxLines: null,
                                decoration: textBoxDeco.copyWith(
                                    hintText: 'Additional notes'
                                ),
                                onSaved: (val) => model.setComments(val)
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceRegular,
                      if (model.chosenLocationAddress != null)
                        Text(
                          model.chosenLocationAddress,
                          style: blackBodyText,
                        ),
                      verticalSpaceRegular,
                      GestureDetector(
                        onTap: () => model.showPlacePicker(),
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
                            'Select Location',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceLarge,
                      GestureDetector(
                        onTap: () => model.submitOrder(_formKey, context, location),
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
                            'Submit Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
    );
  }
}