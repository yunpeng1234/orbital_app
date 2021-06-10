import 'package:flutter/material.dart';
import 'package:orbital_app/services/service_locator.dart';
import 'package:orbital_app/services/geolocation_service.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:flutter/cupertino.dart';

class LocationTesting extends StatefulWidget {

  @override
  _LocationTestingState createState() => _LocationTestingState();
}

class _LocationTestingState extends State<LocationTesting> {
  final _geolocator = serviceLocator<GeolocationService>();
  String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Location Testing'),
          automaticallyImplyLeading: true,
        ),
        backgroundColor: primaryColor,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Text('Use emulator to set location'),
            GestureDetector(
              onTap: () async {
                var temp = await _geolocator.getAddress();
                setState(() {
                  address = temp;
                });
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: greyButtonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Text(
                  'Get address',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            verticalSpaceRegular,
            if (address != null) Text(address),
          ],
        )
    );
  }
}