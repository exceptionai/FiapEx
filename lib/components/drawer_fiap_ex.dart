//Flutter
import 'package:flutter/material.dart';

class DrawerFiapEx extends StatelessWidget {

  final String route;

  const DrawerFiapEx({this.route});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(color: Theme.of(context).accentColor),
          _drawerContent(context),
        ],
      ),
    );
  }

  Widget _drawerContent(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            right: 15,
            top: 30,
            child: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 30),
            children: <Widget>[
              Column(children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/profilepic.jpg'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Flávio Moreni',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'GothamHTF',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white10,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                              child: Row(
                                children: <Widget>[

                    route == '/' ? 
                    Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ) : Padding(padding: EdgeInsets.only(left:25),),
                                  Text(
                  'LISTAS DE CHAMADA',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'GothamHTF',
                      fontWeight: FontWeight.bold,
                      color: _routeColor('/',context)),
                ),
                                ],
                              ),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              // SizedBox(height: 30,),
              // Text('NOVA CHAMADA',
              //   style: TextStyle(
              //     decoration: TextDecoration.lineThrough,
              //     fontSize: 20.0,
              //     fontFamily: 'GothamHTF',
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    route == '/assignment' ? 
                    Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ) : Padding(padding: EdgeInsets.only(left:25),),
                    
                    Container(
                      
                      child: Text(
                        'ENTREGAS DE TRABALHO',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'GothamHTF',
                            fontWeight: FontWeight.bold,
                            color: _routeColor('/assignment',context)),
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/assignment');
                },
              ),
              SizedBox(
                height: 30,
              ),
              // Text('NOVA ENTREGA DE TRABALHO',
              //   style: TextStyle(
              //     decoration: TextDecoration.lineThrough,

              //     fontSize: 20.0,
              //     fontFamily: 'GothamHTF',
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white
              //   ),
              // ),
              // SizedBox(height: 30,),
            ],
          ),
        ],
      ),
    );
  }

  Color _routeColor(String route, BuildContext context){
    if(this.route == route){
      return Theme.of(context).primaryColor;
    }
    return Colors.white;
  }

  Widget _headerTitle(String title) {
    return Positioned(
      top: 8.0,
      left: 0.0,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 34.0,
            fontFamily: 'GothamHTF',
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}
