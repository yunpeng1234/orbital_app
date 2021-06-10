import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/models/dummy_location.dart';

class HomeScreenCard extends StatelessWidget {
  final DummyLocation location;
  final Function onCardTapped;

  const HomeScreenCard({
    this.location,
    this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 140,
      child: GestureDetector(
        onTap: onCardTapped,
        child: Card(
          margin: EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 140,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    location.url,
                  ),
                ),
              ),
              SizedBox(
                height: 38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        location.title,
                        style: blackBodyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}