import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:orbital_app/shared/constants.dart';

class PredictionCard extends StatelessWidget {
  final Tuple3<String, String, String> info;
  final Function onCardTapped;

  const PredictionCard({
    this.info,
    this.onCardTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onCardTapped,
              child: Column(
                children: <Widget>[
                  Text(
                    info.item2,
                    style: blackBodyText,
                  ),
                  Text(
                    info.item3,
                    style: greyBodyText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}