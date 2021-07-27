import 'package:covid_simple_tracker/models/additional_stats.dart';
import 'package:covid_simple_tracker/models/country/province_covid.dart';
import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/views/status_screen/status_template.dart';
import 'package:flutter/material.dart';

class ProvinceScreen extends StatefulWidget {
  ProvinceScreen({Key? key, required this.countryName}) : super(key: key);
  final String countryName;

  @override
  _ProvinceScreenState createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  late Future<List> provinces;

  Future<List> getProvinces() async {
    var additional = AdditionalDetail(name: widget.countryName);
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
      body: FutureBuilder<List>(
        future: provinces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('$snapshot.Error');
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                bool isEmpty = snapshot.data!.length == 1;
                String provinceName = isEmpty
                    ? '${widget.countryName}'
                    : '${snapshot.data![index]['provinceState']}';
                print(provinceName);
                return ListTile(
                  title: Text(provinceName),
                  onTap: () async {
                    Covid provinceCovid = CovidProvince(
                        '${snapshot.data![index]['provinceState']}',
                        provinces: snapshot.data!,
                        index: index);
                    await provinceCovid.getFetchConfirmed();
                      await provinceCovid.getFetchCured();
                      await provinceCovid.getLastUpdate();
                      await provinceCovid.getFetchDeath();
                      print(
                          '${provinceCovid.confirmed}, ${provinceCovid.cured}, ${provinceCovid.death}, ${provinceCovid.lastUpdate}');
                  },
                );
              });
        },
      ),
    );
  }
}
