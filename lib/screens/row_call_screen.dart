import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:flutter/material.dart';

class RowCallScreen extends StatelessWidget {
  const RowCallScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(action: Padding(
               padding: const EdgeInsets.all(8.0),
               child: InkWell(
                 child: Image.asset('assets/images/entregatrabalhos.png',
                          height: 26),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/assignment');
                },
              ),
             )),
      drawer: DrawerFiapEx(route: '/',),
      body: Container(
        
          color: Theme.of(context).accentColor,
          width: MediaQuery.of(context).size.width,
          child: Column(
            
            children: <Widget>[
              SizedBox(height: 30,),
              InkWell(
                child: Text('Gabriel Lopes Pontes'),
                onTap: (){
                  _showModalStudent(context);
                },
              ),
            ],
          )
      ),
    );
  }

  _showModalStudent(BuildContext context){
    showModalBottomSheet(context: context,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
      ),
           
    ),backgroundColor: Theme.of(context).accentColor, builder: (BuildContext context){
      return Container(
        height: 800,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),

              borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage('assets/images/students/lopes.jpeg'),
                  fit: BoxFit.cover

                )
              ),
            ),
            SizedBox(height: 20,),
            Text('GABRIEL LOPES PONTES'),
            SizedBox(height: 25,),
            Row(
              children: <Widget>[
                SizedBox(width: 15,),
                Text('Presença: '),
                SizedBox(width: 10,),
                Text('2 ',style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold),),
                
                SizedBox(width: 40,),
                Text('Ausência: '),
                SizedBox(width: 10,),
                Text('35 ',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
                
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                SizedBox(width: 15,),
                Text('Status Atual: '),
                SizedBox(width: 40,),
                Image.asset('assets/images/pendenteicone.png',width: 35,),
                SizedBox(width: 10,),
                Text('Pendente '),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: Image.asset('assets/images/presenteicone.png',width: 35,),
                  onPressed: (){

                    // TODO: service/repository set as present

                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  child: Image.asset('assets/images/ausenteicone.png',width: 35,),
                  onPressed: (){

                    // TODO: service/repository set as absent

                    Navigator.of(context).pop();
                    
                  },
                ),
              ],
            )

          ],
        ),
      );
    });
  }
}