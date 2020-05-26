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
                Icon(Icons.chevron_left,color: Theme.of(context).primaryColor,),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        )),
        drawer: DrawerFiapEx(
          route: '/',
        ),
        body: Container(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(right: 17.0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 17.0, 0, 17.0),
                      child: Text(
                        "LISTA DE CHAMADA",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(17.0, 0, 0, 0),
                      child: Text(
                        "3° ANO - 3SIT - 2020",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left:17.0, top:5.0, bottom: 30.0),
                      child: Text(
                        "DESENVOLVIMENTO CROSS PLATFORM",
                        style: TextStyle(
                          fontSize: 17.0,
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
