import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/repository/roll_repository.dart';
import 'package:FiapEx/tiles/row_call_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RowCallHistoryScreen extends StatelessWidget {

  RollRepository repository = new RollRepository();
  
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
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
        onPressed: (){

        },
      ),
      drawer: DrawerFiapEx(
        route: '/',
      ),
      body: Container(
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          child: ListView(

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
              FutureBuilder<List<RollModel>>(
                future: repository.getAllRolles(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    if(snapshot.data.length > 0){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          return RowCallHistoryTile(snapshot.data[index]);
                        }
                      );
                    }
                    return Center(child: Icon(Icons.sentiment_dissatisfied,color: Theme.of(context).primaryColor,size: 90,));
                  }
                  return Center(child:CircularProgressIndicator());
                },
              )
            ],
          )),
    );
  }
}
