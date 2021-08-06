import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/services/api_country_list.dart';
import 'package:covid_simple_tracker/services/search_service.dart';

import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.countryResult}) : super(key: key);
  final List<Covid> countryResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

///Textfield buat nyari
class Searcher extends StatefulWidget {
  Searcher({Key? key}) : super(key: key);

  @override
  _SearcherState createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  TextEditingController searchController = TextEditingController();
  late List countries;
  late bool isAvailableCountry;

  void getCountries() async {
    var service = APIListCountry();
    countries = await service.getCountryList();
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Future<List> countryFound() async {
    List filteredCountries = countries.where((element) {
      String countryName = element['name'];
      return searchCountry(
          searchController.text.toLowerCase(), countryName.toLowerCase());
    }).toList();
    return filteredCountries;
  }
//TODO: implement textfield and style the autocomplete
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(optionsBuilder: (textEditingValue) {
      List<String> countryNames = countries
          .map((dynamic country) => country['name'].toString())
          .toList();

      return countryNames.where((String element) =>
          element.toLowerCase().startsWith(textEditingValue.text));
    });
  }
}



// TextField(
//         controller: searchController,
//         style: Theme.of(context).textTheme.headline6,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: mainTextFieldBackGroundColor,
//           suffixIcon: IconButton(
//               color: iconColor,
//               onPressed: () async {
//                 List finalCountries = await countryFound();
//                 print(finalCountries);
//               },
//               icon: Icon(Icons.search)),
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: borderColor)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(width: 2, color: borderColor)),
//         ));
