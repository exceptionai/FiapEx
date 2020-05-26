import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/tiles/row_call_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RowCallHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(
          action: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Image.asset('assets/images/entregatrabalhos.png', height: 26),
          onTap: () {
            Navigator.of(context).pushNamed('/assignment');
          },
        ),
      )),
      drawer: DrawerFiapEx(
        route: '/',
      ),
      body: Container(
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          child: ListView(

            children: <Widget>[
              RowCallHistoryTile(),
              RowCallHistoryTile(done: true),
              RowCallHistoryTile(done: true),
              RowCallHistoryTile(done: true),
              RowCallHistoryTile(done: true),
              RowCallHistoryTile(done: true),
              RowCallHistoryTile(done: true),
              RowCallHistoryTile(done: true),
            ],
          )),
    );
  }
}
