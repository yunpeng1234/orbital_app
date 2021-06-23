import 'package:flutter/material.dart';
import 'package:orbital_app/models/my_location.dart';

class LocationSearchResult extends StatelessWidget {
  final MyLocation location;
  final Function onCardTapped;

  const LocationSearchResult({
    this.location,
    this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onCardTapped,
            child: Card(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Text(location.name),
            ),
          ),
        ),
      ],
    );
  }
}