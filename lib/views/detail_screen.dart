import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:covid_simple_tracker/views/country/provice_screen.dart';
import 'package:covid_simple_tracker/views/status_screen/status_template.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatelessWidget {
  const CountryDetail({Key? key, required this.covidInfo}) : super(key: key);
  final Covid covidInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail ${covidInfo.name}'), //country name
        actions: <Widget>[
          //temp
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProvinceScreen(
                          countryName: covidInfo.name,
                        ))),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CovidStatusIndicator(covid: covidInfo)),
          DetailProvinsi()
        ],
      ),
    );
  }
}

class DetailProvinsi extends StatelessWidget {
  const DetailProvinsi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.17,
        minChildSize: 0.17,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            child: Container(
              width: double.infinity,
              child: ListView(
                controller: scrollController,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Text('Tarik untuk melihat detail per provinsi', style: Theme.of(context).textTheme.caption),
                    Text('Detail Provinsi', style: Theme.of(context).textTheme.headline5)
                  ]),
            ),
          );
        });
  }
}
