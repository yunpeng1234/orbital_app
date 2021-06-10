import 'package:flutter/material.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/view_models/submit_order_flow/input_order_view_model.dart';
import 'package:orbital_app/models/dummy_location.dart';

class InputOrderView extends StatelessWidget {
  final DummyLocation location;
  final _formKey = GlobalKey<FormState>();

  InputOrderView({
    Key key,
    this.location,
  }) : super(key: key);


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
                        validator: (val) => val.isEmpty ? 'Please enter your order.' : null,
                      ),
                      verticalSpaceRegular,
                      TextFormField(
                        minLines: 1,
                        maxLines: null,
                        decoration: textBoxDeco.copyWith(
                            hintText: 'Additional notes'
                        ),
                        onSaved: (val) => model.setNotes(val)
                      ),
                    ],
                  ),
                ),
                verticalSpaceLarge,
                GestureDetector(
                  onTap: () => model.submitOrder(_formKey, context),
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