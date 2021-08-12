
import 'package:covid_simple_tracker/models/global/global_covid.dart';
import 'package:covid_simple_tracker/views/search/search_screen.dart';
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
      child: SingleChildScrollView(
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
      ),
    );
  }
}


