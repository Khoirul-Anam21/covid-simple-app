import 'dart:convert';

import 'package:http/http.dart';

class CovidGlobalAPIService {
  final String _urlGlobal = 'https://covid19.mathdro.id/api';

  Future<dynamic> getGlobalData() async {
    var response = await get(Uri.parse(_urlGlobal));
    if (response.statusCode == 200) {
      Map<String, dynamic> dataResult = jsonDecode(response.body);
      return dataResult;
    }
  }

  Future<dynamic> getLastUpdate() async {
    var response = await get(Uri.parse(_urlGlobal));
    if (response.statusCode == 200) {
      Map<String, dynamic> dataResult = jsonDecode(response.body);
      return dataResult['lastUpdate'];
    }
    return 'Failed to get data';
  }
}