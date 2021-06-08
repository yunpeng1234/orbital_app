import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/submit_order_flow/input_order_view_model.dart';
import 'package:orbital_app/models/location.dart';

class InputOrderView extends StatelessWidget {
  final Location location;
  final _formKey = GlobalKey<FormState>();

  InputOrderView({
    Key key,
    this.location,
  }) : super(key: key);

  Future _showSuccessDialog(BuildContext context, InputOrderViewModel model) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>  AlertDialog(
        title: Center(child: const Text('Successfully submitted!')),
        titleTextStyle: blackBodyTextLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () => model.navigateToHome(),
              child: const Text(
                'RETURN TO HOME',
                style: brownButtonText,
              ),
            ),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InputOrderViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Input Order',
              style: titleText,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter your order';
                          }
                          return null;
                        },
                      ),
                      verticalSpaceRegular,
                      TextFormField(
                        minLines: 1,
                        maxLines: null,
                        decoration: textBoxDeco.copyWith(
                            hintText: 'Additional notes'
                        ),
                        onSaved: (val) {
                          model.setNotes(val);
                        },
                      ),
                    ],
                  ),
                ),
                verticalSpaceLarge,
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      model.submitOrder();
                    }
                    if (! model.error) {
                      _showSuccessDialog(context, model);
                    }
                  },
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
                      'Submit',
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
        )
    );
  }
}