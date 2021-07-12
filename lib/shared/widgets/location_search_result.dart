import 'package:flutter/material.dart';
import 'package:orbital_app/models/my_location.dart';
import 'package:orbital_app/shared/constants.dart';

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
        Column(
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(location.photoUrl),
              ),
            ),
          ],
        ),
        Expanded(
          child: GestureDetector(
            onTap: onCardTapped,
            child: Container(
              height: 100,
              child: Card(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    location.name,
                    textAlign: TextAlign.center,
                    style: blackBodyText,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}