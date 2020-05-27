import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/tiles/student_row_call_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                        "3° ANO - 3SIT - 25/05/2020",
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
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: () => showConfirmDialog(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  showConfirmDialog(BuildContext context){
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Finalizar Chamada',style: TextStyle(color: Theme.of(context).primaryColor),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), topLeft: Radius.circular(15))),
        content: 
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Deseja realmente finalizar a chamada?', style: TextStyle(color: Colors.white),),
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  Text('Alunos: ', style: TextStyle(color: Colors.white),),
                  Icon(Icons.person_outline,color: Colors.lightBlueAccent,),
                  Text('40 ', style: TextStyle(color: Colors.lightBlueAccent),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Presentes: ', style: TextStyle(color: Colors.white),),
                  Image.asset(
                    'assets/images/presenteicone.png',
                    height: 15, 
                  ),
                  Text(' 30 ', style: TextStyle(color: Colors.greenAccent),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Ausentes: ', style: TextStyle(color: Colors.white),),
                  Image.asset(
                    'assets/images/ausenteicone.png',
                    height: 15, 
                  ),
                  Text(' 10 ', style: TextStyle(color: Colors.redAccent),),
                ],
              ),
              SizedBox(height: 15,),
              Text('Data: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())} ', style: TextStyle(color: Colors.white),),
              
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(child: Text('Sim', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: 18)),onPressed: (){Navigator.of(context).pop();},),
                  FlatButton(child: Text('Não', style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: 18)),onPressed: (){Navigator.of(context).pop();},),
                ],
              ),
              
            ],
          ),
        elevation: 24,
        
      ),
      barrierDismissible: true);
  }

  
}
