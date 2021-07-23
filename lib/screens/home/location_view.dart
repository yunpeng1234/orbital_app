import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/home/location_view_model.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:flutter/services.dart';

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
      onModelReady: (model) => model.getCurrentPosition(),
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
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      verticalSpaceRegular,
                      Text(
                        location.name,
                        style: blackBodyText,
                      ),
                      verticalSpaceRegular,
                      Text(
                        location.address,
                        style: blackBodyText,
                      ),
                      verticalSpaceRegular,
                      if (model.deliveryLocationAddress != null) Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              'Your Address: \n${model.deliveryLocationAddress}',
                              style: blackBodyText,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceRegular,
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
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^$|^(0|([0-9]{0,2}))(\.[0-9]{0,2})?$')),
                                // FilteringTextInputFormatter.allow(r'^?:\.\d{1,2}$'),
                              ],
                              decoration: textBoxDeco.copyWith(
                                  hintText: 'Enter the delivery fee for your order.'
                              ),
                              onSaved: (val) {
                                model.setFee(val);
                              },
                              validator: (val) => val.isEmpty || (int.tryParse(val) ?? double.parse(val)) <= 0 ? 'Please enter a value that\'s more than 0.' : null,
                            ),
                            verticalSpaceRegular,
                            TextFormField(
                                minLines: 1,
                                maxLines: null,
                                decoration: textBoxDeco.copyWith(
                                    hintText: 'Additional notes.'
                                ),
                                onSaved: (val) => model.setComments(val)
                            ),
                            verticalSpaceRegular,
                            TextFormField(
                                minLines: 1,
                                maxLines: null,
                                decoration: textBoxDeco.copyWith(
                                    hintText: 'Address Details e.g. floor, unit no.'
                                ),
                                onSaved: (val) => model.setDetails(val)
                            ),
                          ],
                        ),
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
                            'Change Address',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceRegular,
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
            ),
          ),
        )
    );
  }
}