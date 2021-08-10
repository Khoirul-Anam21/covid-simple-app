import 'package:covid_simple_tracker/views/country/country_screen.dart';

import 'package:covid_simple_tracker/views/global/global_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:covid_simple_tracker/themes/mainColours.dart';

void main() {
  // LicenseRegistry.addLicense(()async*{
  //   final license = await rootBundle.loadString('google_fonts/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: mainBottomNavbarColor,
            scaffoldBackgroundColor: mainBackgroundColor,
            textTheme: TextTheme(
                headline6: GoogleFonts.roboto(
                    fontSize: 14, color: textColor.withOpacity(0.8)),
                headline5: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: textColor.withOpacity(0.65)),
                caption: GoogleFonts.roboto(
                    fontSize: 12, color: textColor.withOpacity(0.65)),
                bodyText1: GoogleFonts.roboto(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: textColor))),
        home: MyHomePage(title: 'demo gays'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  EdgeInsets tabsPadding = EdgeInsets.symmetric(vertical: 12, horizontal: 18);
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = <Widget>[
      GlobalScreen(),
      CountriesScreen(),
      Center(child: Text('Setting'))
    ];

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
            body: screens.elementAt(_index),
            bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: mainBottomNavbarColor,
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: GNav(
                      color: iconColor.withOpacity(0.6),
                      activeColor: iconColor.withOpacity(0.8),
                      rippleColor: Colors.grey[300]!,
                      hoverColor: Colors.grey[100]!,
                      tabBackgroundColor: Colors.grey[850]!,
                      duration: Duration(milliseconds: 450),
                      selectedIndex: _index,
                      onTabChange: (index) {
                        setState(() {
                          _index = index;
                        });
                      },
                      gap: 8,
                      tabs: [
                        GButton(
                            padding: tabsPadding,
                            icon: Icons.public,
                            text: 'Global'),
                        GButton(
                            padding: tabsPadding,
                            icon: Icons.list,
                            text: 'Countries'),
                        GButton(
                            padding: tabsPadding,
                            icon: Icons.settings,
                            text: 'Setting')
                      ],
                    )))),
      ),
    );
  }
}
