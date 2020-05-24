import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:FiapEx/repository/assignment_repository.dart';
import 'package:flutter/material.dart';

class AssignmentDeliveriesScreen extends StatefulWidget {
  final AssignmentModel assignment;
  const AssignmentDeliveriesScreen({Key key, this.assignment})
      : super(key: key);

  @override
  _AssignmentDeliveriesScreenState createState() =>
      _AssignmentDeliveriesScreenState();
}

class _AssignmentDeliveriesScreenState
    extends State<AssignmentDeliveriesScreen> {
  AssignmentRepository assignmentRepository = AssignmentRepository();

  final GlobalKey<FormState> observationsFormKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        color: Theme.of(context).accentColor,
        child: Column(
          children: <Widget>[
            observationsForm(),
          ],
        ),
      ),
    );
  }

  Form observationsForm() {
    return Form(
      key: observationsFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: widget.assignment.observations,
            decoration: new InputDecoration(
              icon: const Icon(Icons.text_fields),
              hintText: 'Digite suas observações...',
              labelText: 'Observações',
            ),
            validator: (value) {
              return null;
            },
            onSaved: (value) {
              widget.assignment.observations = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text("Salvar"),
              onPressed: () {
                if (observationsFormKey.currentState.validate()) {
                  observationsFormKey.currentState.save();

                  assignmentRepository.update(widget.assignment);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
