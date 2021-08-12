import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/services/api_country_list.dart';
import 'package:covid_simple_tracker/services/search_service.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:covid_simple_tracker/views/search/query_screen.dart';

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

  Future<bool> isCountrySearchShow(FocusNode focus) async {
    return focus.hasFocus;
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  Future<List> countryFound(String searchValue) async {
    List filteredCountries = countries.where((element) {
      String countryName = element['name'];
      return searchCountry(
          searchValue.toLowerCase(), countryName.toLowerCase());
    }).toList();
    return filteredCountries;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
        fieldViewBuilder: (context, textController, nodeFocus, callBack) {
      return WillPopScope(
        onWillPop: () async {
          nodeFocus.addListener(() {
            print('www ${nodeFocus.hasFocus}');
          });
          // bool isCountriesSearchOpen = await isCountrySearchShow(nodeFocus);
          print('wwws ${nodeFocus.hasFocus}');
          return !nodeFocus.hasFocus;
        },
        child: TextField(
            focusNode: nodeFocus,
            controller: textController,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              filled: true,
              fillColor: mainTextFieldBackGroundColor,
              suffixIcon: IconButton(
                  color: iconColor,
                  onPressed: () async {
                    List finalCountries =
                        await countryFound(textController.text);
                    print(finalCountries);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountryQuery(
                                countryResult: finalCountries,
                                searchValue: textController.text)));
                  },
                  icon: Icon(Icons.search)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 2, color: borderColor)),
            )),
      );
    }, optionsBuilder: (textEditingValue) {
      List<String> countryNames = countries
          .map((dynamic country) => country['name'].toString())
          .toList();

      return countryNames.where((String element) =>
          element.toLowerCase().startsWith(textEditingValue.text));
    }, optionsViewBuilder:
            (listContext, onSelected, Iterable<String> countries) {
      return Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(right: 50),
          height: 300,
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: 400,
          ),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries.elementAt(index);
                return ListTile(
                    tileColor: mainBackgroundColor,
                    title: Text(country,
                        style: Theme.of(context).textTheme.headline6),
                    onTap: () => onSelected(country));
              }),
        ),
      );
    });
  }
}
