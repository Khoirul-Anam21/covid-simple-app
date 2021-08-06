import 'package:covid_simple_tracker/models/country/country_covid.dart';
import 'package:covid_simple_tracker/services/api_country_list.dart';

import 'package:covid_simple_tracker/themes/mainColours.dart';

import 'package:covid_simple_tracker/views/detail_screen.dart';
import 'package:flutter/material.dart';

class ListCountry extends StatefulWidget {
  const ListCountry({Key? key}) : super(key: key);

  @override
  _ListCountryState createState() => _ListCountryState();
}

class _ListCountryState extends State<ListCountry> {
  late Future<List> countries;
  late String countryName;

  @override
  void initState() {
    getCountries();
    countries = getCountries();
    super.initState();
  }

  Future<List> getCountries() async {
    var service = APIListCountry();
    var countries = await service.getCountryList();
    print(countries);
    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('GAGAL');
          }

          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (builder, index) {
                countryName = snapshot.data![index]['name'];
                bool haveNoID = snapshot.data![index]['iso2'] == null;
                return ListCountryTile(

                  country: snapshot.data![index],
                  index: index,
                  initial: haveNoID
                      ? '${countryName[0].toUpperCase()}${countryName[1].toUpperCase()}'
                      : '${snapshot.data![index]['iso2']}',
                );
              });
        });
  }
}

class ListCountryTile extends StatelessWidget {
  const ListCountryTile(
      {Key? key,

      required this.country,
      required this.index,
      this.initial})
      : super(key: key);


  final Map country;
  final int index;
  final String? initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        title: Text(
          country['name'],
          style: Theme.of(context).textTheme.headline6,
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CountryDetail(
                covidInfo: CovidCountry(country['name']),
              ),
            )),
        tileColor: tileListColor,
        leading: CircleAvatar(
          backgroundColor: logoCountryColor,
          child: Text('$initial'),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: borderColor,
            )),
      ),
    );
  }
}
