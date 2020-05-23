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
      drawer: DrawerFiapEx(),
      body: Container(
          color: Color(0xff151819),
      ),
    );
  }
}