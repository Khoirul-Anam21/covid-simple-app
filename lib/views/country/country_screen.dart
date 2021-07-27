import 'package:covid_simple_tracker/views/global/global_screen.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topTitle = Theme.of(context).textTheme.headline6;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'CovTrack',
                style: topTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              Searcher(),
              const SizedBox(height: 20),
            ]));
  }
}
