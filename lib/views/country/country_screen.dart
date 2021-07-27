import 'package:covid_simple_tracker/views/global/global_screen.dart';
import 'package:covid_simple_tracker/views/listing_screen/list_countries.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: SingleChildScrollView(//sementara
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
                ListCountry()
              ]),
        ));
  }
}
