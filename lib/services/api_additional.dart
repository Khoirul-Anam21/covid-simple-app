import 'dart:convert';

import 'package:http/http.dart';
///[APIAdditional] getting provinces and its properties
class APIAdditional {
  String _url = 'https://covid19.mathdro.id/api/confirmed';

  Future<List> getAdditionalDetailList() async {
    var response = await get(Uri.parse(_url));
    if (response.statusCode == 200) {
      try {
        var dataResult = jsonDecode(response.body);
        return dataResult;//list of mapped countries
      } catch (e) {
        print(e);
      }
    }
    return [];
  }
}

