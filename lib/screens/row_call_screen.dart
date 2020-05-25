import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/tiles/student_row_call_tile.dart';
import 'package:flutter/material.dart';

class RowCallScreen extends StatelessWidget {
  const RowCallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarFiapEx(
            action: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child:
                Image.asset('assets/images/entregatrabalhos.png', height: 26),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/assignment');
            },
          ),
        )),
        drawer: DrawerFiapEx(
          route: '/',
        ),
        body: Container(
          color: Color(0xff151819),
          padding: EdgeInsets.only(right: 17.0),
          child: ListView(
            children: <Widget>[
              Container(
                color: Color(0xff151819),
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 17.0, 0, 17.0),
                      child: Text(
                        "LISTA DE CHAMADA",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'GothamHTF',
                          color: Color(0xffED145B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff151819),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(17.0, 0, 0, 0),
                      child: Text(
                        "3° ANO - 3SIT - 2020",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'GothamHTF',
                          fontWeight: FontWeight.bold,
                          color: Color(0xffED145B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff151819),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(17.0, 5.0, 17.0, 30.0),
                      child: Text(
                        "DESENVOLVIMENTO CROSS PLATFORM",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'GothamHTF',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StudentRowCallTile(),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ButtonTheme(
                      buttonColor: Theme.of(context).primaryColor,
                      child: RaisedButton(
                          child: Text(
                            "Finalizar Chamada",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
