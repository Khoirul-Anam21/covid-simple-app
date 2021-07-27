import 'package:covid_simple_tracker/services/api_country_list.dart';
import 'package:covid_simple_tracker/services/api_country_service.dart';
import 'package:covid_simple_tracker/views/country/provice_screen.dart';
import 'package:covid_simple_tracker/views/listing_screen/list_tile.dart';
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

  void navigate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => ProvinceScreen(countryName: countryName)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      child: FutureBuilder<List>(
          future: countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('GAGAL');
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (builder, index) {
                  countryName = snapshot.data![index]['name'];
                  return ListTileTemplate(
                    title: snapshot.data![index]['name'],
                    onTap: () {
                      navigate();
                    },
                  );
                });
          }),
    );
  }
}
