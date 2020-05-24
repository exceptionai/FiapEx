import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:flutter/material.dart';

class AssignmentDeliveriesScreen extends StatefulWidget {
  @override
  _AssignmentDeliveriesScreenState createState() => _AssignmentDeliveriesScreenState();
}

class _AssignmentDeliveriesScreenState extends State<AssignmentDeliveriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFiapEx(
          action: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Image.asset('assets/images/pendenteicone.png', height: 26),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
      )),
      drawer: DrawerFiapEx(),
      body: Container(
        
      ),
    );
  }
}