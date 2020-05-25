import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:FiapEx/models/delivery_model.dart';
import 'package:FiapEx/repository/assignment_delivery_repository.dart';
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
  AssignmentDeliveryRepository assignmentDeliveryRepository =
      AssignmentDeliveryRepository();

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
            Expanded(
              child: FutureBuilder<List>(
                future: assignmentDeliveryRepository
                    .findDeliveriesByAssignmentId(widget.assignment.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.length > 0) {
                      return buildDeliveriesListView(snapshot.data);
                    } else {
                      return Center(
                        child: Text("Nenhuma entrega deste trabalho!"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView buildDeliveriesListView(List<DeliveryModel> deliveries) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: deliveries == null ? 0 : deliveries.length,
      itemBuilder: (BuildContext ctx, int index) {
        return deliveryCard(deliveries[index]);
      },
    );
  }

  Card deliveryCard(DeliveryModel delivery) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Container(
          child: ListTile(
            title: Container(
              child: Column(
                children: <Widget>[
                  Text("Integrantes: "),
                  FutureBuilder<List>(
                    future: assignmentDeliveryRepository
                        .findStudentsByDeliveryId(delivery.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: <Widget>[studentsString(snapshot.data)],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            subtitle: gradeForm(delivery),
          ),
        ),
      ),
    );
  }

  Text studentsString(
      List<DeliveryModel> students /*TODO: change to StudentModel*/) {
    String studentsString = "";

    for (int i = 0; i < students.length; i++) {
      studentsString += "Pedro"; /*TODO: change to students[i].name*/

      if (i + 1 < students.length) {
        studentsString += ", ";
      } else {
        studentsString += ".";
      }
    }

    return Text(studentsString);
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
            keyboardType: TextInputType.text,
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

                  showSnackBar('Observação salva com sucesso!');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Form gradeForm(DeliveryModel delivery) {
    final GlobalKey<FormState> gradeFormKey = new GlobalKey<FormState>();

    return Form(
      key: gradeFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue:
                delivery.grade != null ? delivery.grade.toString() : '',
            decoration: new InputDecoration(
              icon: const Icon(Icons.text_fields),
              hintText: 'Nota...',
              labelText: 'Nota',
            ),
            validator: (value) {
              if ((value.isEmpty)) {
                return 'Digite uma nota!';
              } else if (double.parse(value) < 0) {
                return 'A nota mínima é 0!';
              } else if (double.parse(value) > 10) {
                return 'A nota máxima é 10!';
              }

              return null;
            },
            keyboardType: TextInputType.number,
            onSaved: (value) {
              delivery.grade = double.parse(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text("Salvar"),
              onPressed: () {
                if (gradeFormKey.currentState.validate()) {
                  gradeFormKey.currentState.save();

                  assignmentDeliveryRepository.update(delivery);

                  showSnackBar('Nota salva com sucesso!');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: Text(
          text,
        ),
      ),
    );
  }
}
