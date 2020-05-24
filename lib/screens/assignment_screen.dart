import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*TODO: Delete all until -DELETE UNTIL HERE- when assignmentRepository is ready.*/
    List<AssignmentModel> assignments = List<AssignmentModel>();
    assignments.add(AssignmentModel(
        id: 1,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 1"));
    assignments.add(AssignmentModel(
        id: 2,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 2"));
    assignments.add(AssignmentModel(
        id: 3,
        endDate: DateTime.now(),
        observations: "blablabla",
        subject: "Trabalho 3"));
    /*-DELETE UNTIL HERE-*/
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
        color: Theme.of(context).accentColor,
        child: buildListView(assignments),
        /*TODO: change the child value to the following when assignmentRepository is ready: 
        FutureBuilder<List>(
          future: assignmentRepository.findAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length > 0) {
                return buildListView(snapshot.data);
              } else {
                return Center(
                  child: Text("Nenhum trabalho cadastrado!"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),*/
      ),
    );
  }

  ListView buildListView(List<AssignmentModel> assignments) {
    return ListView.builder(
      itemCount: assignments == null ? 0 : assignments.length,
      itemBuilder: (BuildContext ctx, int index) {
        return assignmentCard(assignments[index]);
      },
    );
  }

  Card assignmentCard(AssignmentModel assignment) {
    return Card(
      elevation: 12.0,
      margin: new EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(
                  width: 1.0,
                  color: Colors.white24,
                ),
              ),
            ),
            child: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
          ),
          title: Text(
            assignment.subject,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: assignmentCardSubtitle(assignment),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
          onTap: () async {},
        ),
      ),
    );
  }

  Column assignmentCardSubtitle(AssignmentModel assignment) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("Data limite para a entrega: "),
            Text(DateFormat("dd-MM-yyyy").format(assignment.endDate)),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
                "Total de entregas: 0"), //TODO: trocar número por assignmentRepository.getDeliveries(assignment.id, "all");
          ],
        ),
        Row(
          children: <Widget>[
            Text(
                "Não avaliados: 0"), //TODO: trocar número por assignmentRepository.getDeliveries(assignment.id, "nonRated");
            Text(" | "),
            Text(
                "Avaliados: 0"), //TODO: trocar número por assignmentRepository.getDeliveries(assignment.id, "rated");
          ],
        ),
      ],
    );
  }
}
