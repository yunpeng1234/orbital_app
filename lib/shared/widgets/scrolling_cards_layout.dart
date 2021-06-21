import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';

class ScrollingCardsLayout extends StatelessWidget {

  final bool isEmpty;
  final String title;
  final String sideButtonText;
  final String noDataText;
  final List<Widget> widgetList;
  final Function onSideButtonTapped;

  ScrollingCardsLayout({
    this.isEmpty,
    this.title,
    this.sideButtonText,
    this.noDataText,
    this.widgetList,
    this.onSideButtonTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: titleText,
            ),
            if (onSideButtonTapped != null) Column(
              children: [
                verticalSpaceTiny,
                GestureDetector(
                  onTap: onSideButtonTapped,
                  child: Text(
                    sideButtonText,
                    style: brownButtonText.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 180,
          child: isEmpty
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  noDataText,
                  style: titleText,
                  textAlign: TextAlign.center,
                  ),
              ],
            )
            : ListView(
              scrollDirection: Axis.horizontal,
              children: widgetList
            ),
        ),
        verticalSpaceRegular,
        // if (onSideButtonTapped != null) GestureDetector(
        //   onTap: onSideButtonTapped,
        //   child: Text(
        //     sideButtonText,
        //     style: brownButtonText.copyWith(
        //         fontWeight: FontWeight.bold),
        //   ),
        // ),
      ],
    );
  }
}
