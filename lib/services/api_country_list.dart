import 'dart:convert';
import 'package:http/http.dart';

class APIListCountry {
  final String _urlCountry = 'https://covid19.mathdro.id/api/countries';

  Future<dynamic> getCountryList() async {
    var response = await get(Uri.parse('$_urlCountry'));
    if (response.statusCode == 200) {
      Map<String, dynamic> dataResult = jsonDecode(response.body);
      return dataResult['countries']; //list of countries MAP
    }
    throw Exception('Failed to fetch');
  }
}
