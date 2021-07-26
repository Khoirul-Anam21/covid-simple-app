import 'package:covid_simple_tracker/models/global/global_covid.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:covid_simple_tracker/views/status_screen/status_template.dart';
import 'package:flutter/material.dart';

class GlobalScreen extends StatelessWidget {
  const GlobalScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final globalCovid = GlobalCovid();
    final topTitle = Theme.of(context).textTheme.headline6;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CovTrack',
              style: topTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            Searcher(),
            const SizedBox(height: 20),
            CovidStatusIndicator(covid: globalCovid)
          ]),
    );
  }
}

class Searcher extends StatefulWidget {
  Searcher({Key? key}) : super(key: key);

  @override
  _SearcherState createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        filled: true,
        fillColor: mainTextFieldBackGroundColor,
          suffixIcon: IconButton(
              color: iconColor, onPressed: () {}, icon: Icon(Icons.search)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: borderColor)),
          )
        
    );
  }
}
