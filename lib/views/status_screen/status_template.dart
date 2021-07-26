import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:flutter/material.dart';

class CovidStatusIndicator extends StatefulWidget {
  const CovidStatusIndicator({Key? key, required this.covid}) : super(key: key);
  final Covid covid;

  @override
  _CovidStatusIndicatorState createState() => _CovidStatusIndicatorState();
}

class _CovidStatusIndicatorState extends State<CovidStatusIndicator> {
  late Future<Covid> covidData;

  @override
  void initState() {
    super.initState();
    getData();
    covidData = getData();
  }

  Future<Covid> getData() async {
    await widget.covid.getFetchConfirmed();
    await widget.covid.getFetchCured();
    await widget.covid.getFetchDeath();
    await widget.covid.getLastUpdate();
    return widget.covid;
  }

  @override
  Widget build(BuildContext context) {
    var captionStyle = Theme.of(context).textTheme.caption;
    var bodyStyle = Theme.of(context).textTheme.bodyText1;
    var alignLeft = CrossAxisAlignment.start;
    return Container(
      child: Column(children: <Widget>[
        FutureBuilder<Covid>(
            future: covidData,
            builder: (context, snapshot) {
              String countryStatus = '';
              dynamic lastUpdate;
              if (snapshot.connectionState == ConnectionState.waiting) {
                countryStatus = 'Loading...';
                lastUpdate = 'Loading...';
              } else if (snapshot.hasError) {
                countryStatus = '${snapshot.error}';
                lastUpdate = '${snapshot.error}';
              } else {
                countryStatus = '${snapshot.data!.name!}';
                lastUpdate = '${snapshot.data!.lastUpdate}';
              }
              var date = DateTime.tryParse(lastUpdate);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Status Covid: $countryStatus',
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                            'Last Update $date',
                            style: captionStyle)
                      ]),
                  IconButton(
                      color: iconColor,
                      onPressed: () {
                        setState(() {
                          covidData = getData();
                        });
                      },
                      icon: Icon(Icons.refresh)),
                ],
              );
            }),
        const SizedBox(
          height: 10,
        ),
        renderCovidStats(alignLeft, captionStyle!, bodyStyle!),
      ]),
    );
  }

  Widget renderCovidStats(CrossAxisAlignment alignLeft, TextStyle captionStyle,
      TextStyle bodyStyle) {
    String loading = 'Loading...';
    String error = 'no data';
    String death = '';
    String recovered = '';
    String confirmed = '';

    return FutureBuilder<Covid>(
        future: covidData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            confirmed = loading;
            death = loading;
            recovered = loading;
          } else if (snapshot.hasError) {
            confirmed = error;
            death = error;
            recovered = error;
          } else {
            confirmed = '${snapshot.data!.confirmed}';
            death = '${snapshot.data!.death}';
            recovered = '${snapshot.data!.cured}';
          }
          return Column(
            children: [
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: recoveredColor),
                  child: Column(
                    crossAxisAlignment: alignLeft,
                    children: <Widget>[
                      Text('Sembuh', style: captionStyle),
                      const SizedBox(height: 10),
                      Text('$recovered', style: bodyStyle),
                      Text('Kasus', style: captionStyle),
                      const SizedBox(
                        height: 14,
                      )
                    ],
                  )),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: confirmedColor),
                  child: Column(
                    crossAxisAlignment: alignLeft,
                    children: <Widget>[
                      Text('Terkonfirmasi', style: captionStyle),
                      const SizedBox(height: 10),
                      Text('$confirmed', style: bodyStyle),
                      Text('Kasus', style: captionStyle),
                      const SizedBox(
                        height: 14,
                      )
                    ],
                  )),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: deathsColor),
                  child: Column(
                    crossAxisAlignment: alignLeft,
                    children: <Widget>[
                      Text('Sembuh', style: captionStyle),
                      const SizedBox(height: 10),
                      Text('$death', style: bodyStyle),
                      Text('Kasus', style: captionStyle),
                      const SizedBox(
                        height: 14,
                      )
                    ],
                  )),
            ],
          );
        });
  }
}
