import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/tiles/row_call_history_tile.dart';
import 'package:FiapEx/screens/new_roll_call_screen.dart';
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
      floatingActionButton: FloatingActionButton(
                heroTag: "button",
                onPressed: () {
                  Navigator.of(context).pushNamed('/new');
                },
                child: Icon(Icons.exposure_plus_1),
                backgroundColor: Color.fromRGBO(237, 20, 91, .9),
              ),
      drawer: DrawerFiapEx(
        route: '/',
      ),
      body: Container(
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          child: 
              ListView(
              children: <Widget>[
                Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Text(
                    "HISTÓRICO DE CHAMADAS",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
                RowCallHistoryTile(),
                RowCallHistoryTile(done: true),
                RowCallHistoryTile(done: true),
                RowCallHistoryTile(done: true),
                RowCallHistoryTile(done: true),
                RowCallHistoryTile(done: true),
                RowCallHistoryTile(done: true),
                RowCallHistoryTile(done: true),
              ],
            ),
      ),
    );
  }
}
