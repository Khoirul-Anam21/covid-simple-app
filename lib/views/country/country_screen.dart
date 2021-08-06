import 'package:covid_simple_tracker/themes/mainColours.dart';

import 'package:covid_simple_tracker/views/country/list_countries.dart';
import 'package:covid_simple_tracker/views/search_screen.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  Widget build(BuildContext context) {
    final topTitle = Theme.of(context).textTheme.headline6;
    
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  color: mainBackgroundColor,
                  child: Column(
                    children: [
                      Text(
                        'CovTrack',
                        style: topTitle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Searcher(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text('Daftar Negara',
                        style: Theme.of(context).textTheme.headline5),
                    ListCountry(),
                  ],
                )
              ]),
        ));
  }
}
