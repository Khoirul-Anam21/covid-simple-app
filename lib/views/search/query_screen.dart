import 'package:covid_simple_tracker/views/country/list_countries.dart';
import 'package:flutter/material.dart';

class CountryQuery extends StatelessWidget {
  const CountryQuery({Key? key, required this.countryResult, this.searchValue})
      : super(key: key);
  final List countryResult;
  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    final List<Widget> countriesTiles = countryResult.map((country) {
      bool noId = country['iso2'] == null;
      return ListCountryTile(
          country: country,
          initial: noId
              ? '${country['name'][0]}${country['name'][1]}'.toUpperCase()
              : '${country['iso2']}');
    }).toList();

    final List<Widget> children = [
      Text('Anda Mencari... $searchValue', style: Theme.of(context).textTheme.caption,),
      ...countriesTiles
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Hasil Pencarian')),
      body: ListView(
        children: children,
      ),
    );
  }
}
