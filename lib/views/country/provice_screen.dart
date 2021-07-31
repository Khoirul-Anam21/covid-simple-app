import 'package:covid_simple_tracker/models/additional_stats.dart';
import 'package:covid_simple_tracker/models/country/province_covid.dart';
import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:covid_simple_tracker/views/status_screen/status_template.dart';
import 'package:flutter/material.dart';

class ProvinceScreen extends StatefulWidget {
  ProvinceScreen({Key? key, this.countryName}) : super(key: key);
  final String? countryName;
  //final bool isReloaded

  @override
  _ProvinceScreenState createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  late Future<List> provinces;

  Future<List> getProvinces() async {
    var additional = AdditionalDetail(name: widget.countryName!);
    List datas = await additional.getProvinceOfCountry();
    return datas;
  }

  @override
  void initState() {
    provinces = getProvinces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provinsi Tersedia'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FutureBuilder<List>(
          future: provinces,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('$snapshot.Error');
            }
            return ListProvinceTemplate(
              defaultName: widget.countryName,
              datas: snapshot.data!,
            );
          },
        ),
      ),
    );
  }
}

class ListProvinceTemplate extends StatefulWidget {
  const ListProvinceTemplate(
      {Key? key, required this.defaultName, required this.datas})
      : super(key: key);

  final String? defaultName;
  final List datas;

  @override
  _ListProvinceTemplateState createState() => _ListProvinceTemplateState();
}

class _ListProvinceTemplateState extends State<ListProvinceTemplate> {
  late List<bool> isExpanded;
  @override
  void initState() {
    isExpanded = List.filled(widget.datas.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline6;
    final titleStyle = Theme.of(context).textTheme.headline5;
    final captionStyle = Theme.of(context).textTheme.caption;
    final detailNumberStyle = textStyle!.copyWith(fontWeight: FontWeight.bold);
    final listPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0);
    final iconSize = 30.0;

    return ListView.builder(
        itemCount: widget.datas.length,
        itemBuilder: (context, index) {
          bool noProvinceData = widget.datas[index]['provinceState'] == null;

          String initial = noProvinceData
              ? '${widget.datas[index]['iso2']}'
              : '${widget.datas[index]['provinceState'][1]}';

          String name = noProvinceData
              ? '${widget.defaultName}'
              : '${widget.datas[index]['provinceState']}';

          var deaths = widget.datas[index]['deaths'];
          var confirmed = widget.datas[index]['confirmed'];
          var recovered = widget.datas[index]['recovered'];
          var hospitalized = widget.datas[index]['active'];

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: tileListColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: borderColor)),
            child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: logoCountryColor,
                  child: Text('${initial.toUpperCase()}'),
                ),
                collapsedIconColor: iconColor,
                iconColor: iconColor,
                children: <Widget>[
                  ListTile(
                      dense: true,
                      leading: Icon(Icons.health_and_safety_outlined,
                          size: iconSize, color: recoverIconColor),
                      subtitle: Text('$recovered', style: detailNumberStyle),
                      contentPadding: listPadding,
                      title: Text('Sembuh', style: captionStyle)),
                  ListTile(
                      dense: true,
                      leading: Icon(Icons.sick_outlined,
                          size: iconSize, color: confirmIconColor),
                      subtitle: Text('$confirmed', style: detailNumberStyle),
                      contentPadding: listPadding,
                      title: Text('Terkonfirmasi', style: captionStyle)),
                  ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.airline_seat_individual_suite_outlined,
                        size: iconSize,
                        color: hospitalizedIconColor,
                      ),
                      subtitle: Text('$hospitalized', style: detailNumberStyle),
                      contentPadding: listPadding,
                      title: Text('Dirawat', style: captionStyle)),
                  ListTile(
                      dense: true,
                      leading: Icon(Icons.coronavirus_outlined,
                          size: iconSize, color: deathsIconColor),
                      subtitle: Text('$deaths', style: detailNumberStyle),
                      contentPadding: listPadding,
                      title: Text('Meninggal', style: captionStyle)),
                ],
                title: Text('$name',
                    style: titleStyle)),
          );
        });
  }
}

// Covid provinceCovid = CovidProvince(
//                     '${datas![index]['provinceState']}',
//                     provinces: datas!,
//                     index: index);
//                 await provinceCovid.getFetchConfirmed();
//                 await provinceCovid.getFetchCured();
//                 await provinceCovid.getLastUpdate();
//                 await provinceCovid.getFetchDeath();
//                 print(datas![index]['active']);//hospitalised
//                 print(
//                     '${provinceCovid.confirmed}, ${provinceCovid.cured}, ${provinceCovid.death}, ${provinceCovid.lastUpdate}');