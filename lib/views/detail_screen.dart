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
      ),
      body: Stack(
        children: [
          Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CovidStatusIndicator(covid: covidInfo)),
          DetailProvinsi(
              countryName: covidInfo.name!,)
        ],
      ),
    );
  }
}

class DetailProvinsi extends StatefulWidget {
  const DetailProvinsi(
      {Key? key, required this.countryName})
      : super(key: key);
  final String countryName;


  @override
  _DetailProvinsiState createState() => _DetailProvinsiState();
}

class _DetailProvinsiState extends State<DetailProvinsi> {


  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.17,
        minChildSize: 0.17,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return LayoutBuilder(builder: (context, constraints) {
            bool alreadyDragged = constraints.maxHeight > 200.0;
            String dragCommand = alreadyDragged
                ? 'Tarik kembali untuk menutup'
                : 'Tarik untuk melihat detail per provinsi';
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text('$dragCommand',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 10)),
                          const SizedBox(
                            height: 25,
                          ),
                          Text('Detail Provinsi',
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),
                      alreadyDragged
                          ? ProvinceScreen(countryName: widget.countryName)
                          : Center(
                              child: Text(
                                '...',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )
                    ]),
              ),
            );
          });
        });
  }
}
