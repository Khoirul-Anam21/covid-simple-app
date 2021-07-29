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
          DraggableScrollableSheet(
              initialChildSize: 0.17,
              minChildSize: 0.17,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                    padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                    child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            child: ListView(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                children: List.generate(20, (index) {
                                  return ListTile(
                                      title: Text('Saya Urutan ke $index',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6));
                                })),
                          ),
                          Container(
                            width: double.infinity,
                            color: Colors.amber,
                            padding: const EdgeInsets.all(8.0),
                            child: CustomPaint(painter: LineDraggerPainter()),
                          )
                        ],
                      ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

class LineDraggerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 1.0;
    Offset point1 = Offset((size.width / 2) - 20, 0);
    Offset point2 = Offset((size.width / 2) + 20, 0);
    canvas.drawLine(point1, point2, paint);
  }

  @override
  bool shouldRepaint(LineDraggerPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(LineDraggerPainter oldDelegate) => false;
}
