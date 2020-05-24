import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:flutter/material.dart';

class AssignmentDeliveriesScreen extends StatefulWidget {
  @override
  _AssignmentDeliveriesScreenState createState() =>
      _AssignmentDeliveriesScreenState();
}

class _AssignmentDeliveriesScreenState
    extends State<AssignmentDeliveriesScreen> {
  AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    assignment = ModalRoute.of(context).settings.arguments;

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
        child: Text(assignment.subject),
      ),
    );
  }
}
