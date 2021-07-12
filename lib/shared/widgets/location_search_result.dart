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
        Container(
          width: 100,
          height: 100,
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(location.photoUrl),
          ),
        ),
        Container(
          width: 300,
          height: 100,
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