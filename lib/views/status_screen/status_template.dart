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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Status Covid',
                      style: Theme.of(context).textTheme.headline5),
                  Text('Last Update', style: captionStyle)
                ]),
            IconButton(
                color: iconColor, onPressed: () {}, icon: Icon(Icons.refresh)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: recoveredColor),
            child: Column(
              crossAxisAlignment: alignLeft,
              children: <Widget>[
                Text('Sembuh', style: captionStyle),
                const SizedBox(height: 10),
                Text('90000', style: bodyStyle),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: confirmedColor),
            child: Column(
              crossAxisAlignment: alignLeft,
              children: <Widget>[
                Text('Sembuh', style: captionStyle),
                const SizedBox(height: 10),
                Text('100000', style: bodyStyle),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: deathsColor),
            child: Column(
              crossAxisAlignment: alignLeft,
              children: <Widget>[
                Text('Sembuh', style: captionStyle),
                const SizedBox(height: 10),
                Text('30000', style: bodyStyle),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
      ]),
    );
  }
}
