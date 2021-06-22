import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:orbital_app/shared/constants.dart';

class PredictionCard extends StatelessWidget {
  final Tuple2<String, String> info;
  final Function onCardTapped;

  const PredictionCard({
    this.info,
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
        child: Container(
          height: 50,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Text(
                  info.item1,
                  style: blackBodyText,
                ),
                Text(
                  info.item2,
                  style: greyBodyText,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}