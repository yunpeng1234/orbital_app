import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orbital_app/shared/constants.dart';
import 'package:orbital_app/shared/widgets/location_search_result.dart';
import 'package:orbital_app/shared/loading.dart';
import 'package:orbital_app/screens/base_view.dart';
import 'package:orbital_app/view_models/home/search_results_view_model.dart';

class SearchResultsView extends StatelessWidget {
  final String query;

  const SearchResultsView({
    this.query,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchResultsViewModel>(
      onModelReady: (model) => model.init(query),
      builder: (context, model, child) => model.isBusy()
          ? Center(child: Loading())
          : Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              'Search Results',
              style: titleText,
            ),
          ),
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: model.results
                  .map((result) => LocationSearchResult(
                  location: result,
                  onCardTapped: () => model.navigate('location', arguments: result)))
                  .toList()
            ),
          )
      ),
    );
  }
}
