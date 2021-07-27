import 'package:covid_simple_tracker/services/api_additional.dart';

class AdditionalDetail {
  String name;

  AdditionalDetail({required this.name});

  ///[getProvinceOfCountry]
  Future<List> getProvinceOfCountry() async {
    var additionalInfo = APIAdditional();
    List data = await additionalInfo.getAdditionalDetailList();
    return data
        .where((element) => element['countryRegion'] == name)
        .toList(); //list of mathed country
  }

}

Future<Map> getProvinceDetail(List filteredList, int index) async {    
    return filteredList[index]; //list of mathed country
  }
