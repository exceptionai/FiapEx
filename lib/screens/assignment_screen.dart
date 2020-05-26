import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/components/snackbar_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/repository/assignment_repository.dart';
import 'package:FiapEx/repository/class_repository.dart';
import 'package:FiapEx/repository/discipline_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key key}) : super(key: key);

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  AssignmentRepository assignmentRepository = AssignmentRepository();
  ClassRepository classRepository = ClassRepository();
  DisciplineRepository disciplineRepository = DisciplineRepository();

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
        child: FutureBuilder<List>(
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
        ),
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
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/assignment_deliveries",
                arguments: assignment);
          },
        ),
      ),
    );
  }

  Column assignmentCardSubtitle(AssignmentModel assignment) {
    return Column(
      children: <Widget>[
        classRow(assignment.classId),
        disciplineRow(assignment.disciplineId),
        endDateRow(assignment.endDate),
        buildCardSubtitleData(assignment.id, "all"),
        buildCardSubtitleData(assignment.id, "nonRated"),
        buildCardSubtitleData(assignment.id, "rated"),
        observationsForm(assignment),
      ],
    );
  }

  Row disciplineRow(int disciplineId) {
    return Row(
      children: <Widget>[
        FutureBuilder<DisciplineModel>(
          future: disciplineRepository.getDiscipline(disciplineId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Text(snapshot.data.name);
              } else {
                return Center(
                  child: Text("Sem disciplina"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  Row classRow(int classId) {
    return Row(
      children: <Widget>[
        FutureBuilder<ClassModel>(
          future: classRepository.getClass(classId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Text(snapshot.data.name);
              } else {
                return Center(
                  child: Text("Sem turma"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }

  Row endDateRow(DateTime endDate) {
    return Row(
      children: <Widget>[
        Text("Data limite para a entrega: "),
        Text(DateFormat("dd-MM-yyyy").format(endDate)),
      ],
    );
  }

  Widget buildCardSubtitleData(int assignmentId, String type) {
    return FutureBuilder<int>(
      future: assignmentRepository.getDeliveryAmount(assignmentId, type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return getTextBasedOnType(type, snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Row getTextBasedOnType(String type, int amount) {
    switch (type) {
      case "all":
        return Row(
          children: <Widget>[
            Text("Total de entregas: " + amount.toString()),
          ],
        );
        break;
      case "nonRated":
        return Row(
          children: <Widget>[
            Text("Não avaliados: " + amount.toString()),
          ],
        );
        break;
      default:
        return Row(
          children: <Widget>[
            Text("Avaliados: " + amount.toString()),
          ],
        );
    }
  }

  Row observationsForm(AssignmentModel assignment) {
    final GlobalKey<FormState> observationsFormKey = new GlobalKey<FormState>();

    return Row(
      children: <Widget>[
        Form(
          key: observationsFormKey,
          child: Expanded(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: assignment.observations,
                  maxLines: 5,
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
                    assignment.observations = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    child: Text("Salvar observações"),
                    onPressed: () {
                      if (observationsFormKey.currentState.validate()) {
                        observationsFormKey.currentState.save();

                        assignmentRepository.update(assignment);

                        SnackbarFiapEx(scaffoldKey: scaffoldKey)
                            .show('Observações salvas com sucesso!');

                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
