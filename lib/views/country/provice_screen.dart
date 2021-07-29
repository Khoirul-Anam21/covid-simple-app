import 'package:covid_simple_tracker/models/additional_stats.dart';
import 'package:covid_simple_tracker/models/country/province_covid.dart';
import 'package:covid_simple_tracker/models/covid.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:covid_simple_tracker/views/status_screen/status_template.dart';
import 'package:flutter/material.dart';

class ProvinceScreen extends StatefulWidget {
  ProvinceScreen({Key? key, this.countryName}) : super(key: key);
  final String? countryName;

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
              datas: snapshot.data,
            );
          },
        ),
      ),
    );
  }
}

class ListProvinceTemplate extends StatelessWidget {
  const ListProvinceTemplate({Key? key, required this.defaultName, this.datas})
      : super(key: key);

  final String? defaultName;
  final List? datas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: datas!.length,
        itemBuilder: (context, index) {
          bool isEmpty = datas!.length == 1;
          String provinceName =
              isEmpty ? '${defaultName!}' : '${datas![index]['provinceState']}';
          print(provinceName);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              title: Text(provinceName,
                  style: Theme.of(context).textTheme.headline6),
              onTap: () async {
                Covid provinceCovid = CovidProvince(
                    '${datas![index]['provinceState']}',
                    provinces: datas!,
                    index: index);
                await provinceCovid.getFetchConfirmed();
                await provinceCovid.getFetchCured();
                await provinceCovid.getLastUpdate();
                await provinceCovid.getFetchDeath();
                print(datas![index]['active']);//hospitalised
                print(
                    '${provinceCovid.confirmed}, ${provinceCovid.cured}, ${provinceCovid.death}, ${provinceCovid.lastUpdate}');
              },
              tileColor: tileListColor,
              leading: CircleAvatar(
                backgroundColor: logoCountryColor,
                child: Text(
                    '${provinceName[0].toUpperCase()}${provinceName[1].toLowerCase()}'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: borderColor,
                  )),
            ),
          );
        });
  }
}
