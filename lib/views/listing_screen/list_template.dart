import 'package:covid_simple_tracker/services/api_country_list.dart';
import 'package:covid_simple_tracker/services/api_country_service.dart';
import 'package:covid_simple_tracker/views/country/provice_screen.dart';
import 'package:flutter/material.dart';

class ListCountry extends StatefulWidget {
  const ListCountry({Key? key}) : super(key: key);

  @override
  _ListCountryState createState() => _ListCountryState();
}

class _ListCountryState extends State<ListCountry> {
  late Future<List> countries;

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
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('GAGAL');
          }
          return ListView.builder(itemBuilder: (builder, index) {
            return ListTile(
              title: Text(snapshot.data![index]['name'],
                  style: Theme.of(context).textTheme.headline6),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ProvinceScreen(
                            countryName: snapshot.data![index]['name'])));
              },
            );
          });
        });
  }
}
