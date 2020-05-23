//Flutter
import 'package:flutter/material.dart';

class DrawerFiapEx extends StatelessWidget {
  DrawerFiapEx();

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
              Text(
                'LISTAS DE CHAMADA',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'GothamHTF',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
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
              Text(
                'ENTREGAS DE TRABALHO',
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'GothamHTF',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
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
