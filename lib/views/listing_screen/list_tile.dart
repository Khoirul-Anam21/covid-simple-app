import 'package:covid_simple_tracker/themes/mainColours.dart';
import 'package:flutter/material.dart';

class ListTileTemplate extends StatelessWidget {
  const ListTileTemplate({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        title: Text(title, style: Theme.of(context).textTheme.headline6,),
        onTap: ()=>onTap,
        tileColor: tileListColor,
        leading: CircleAvatar(
          backgroundColor: logoCountryColor,
          child: Text(title[1]),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: borderColor,
            )),
      ),
    );
  }
}
