import 'dart:convert';

import 'package:http/http.dart';

class APICovidService {
  String countryName;
  final String _urlCountry = 'https://covid19.mathdro.id/api/countries';

  APICovidService({required this.countryName});

  Future<dynamic> getCountryList() async {
    var response = await get(Uri.parse('$_urlCountry'));
    if (response.statusCode == 200) {
      Map<String, dynamic> dataResult = jsonDecode(response.body);
      return dataResult['countries']; //list of countries MAP
    }
    throw Exception('Failed to fetch');
  }

  Future<dynamic> getCountryDetail() async {
    var response = await get(Uri.parse('$_urlCountry/$countryName'));
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> dataResult = jsonDecode(response.body);
        return dataResult;
      } catch (e) {
        print(e);
      }
    }
    var nullResult = <String, dynamic>{
      'confirmed': {'value': 'no data'},
      'deaths': {'value': 'no data'},
      'recovered': {'value': 'no data'}
    };
    return nullResult;
  }

  Future<dynamic> getLastUpdate() async {
    var response = await get(Uri.parse('$_urlCountry/$countryName'));
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> dataResult = jsonDecode(response.body);
        return dataResult['lastUpdate'];
      } catch (e) {
        print(e);
      }
    }
    return 'Failed to get data';
  }
}