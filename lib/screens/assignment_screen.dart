import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/repository/assignment_repository.dart';
import 'package:FiapEx/repository/class_repository.dart';
import 'package:FiapEx/repository/discipline_repository.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentScreen extends StatefulWidget {
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
        ),
      ),
      resizeToAvoidBottomPadding: false,
      drawer: DrawerFiapEx(route: '/assignment'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).accentColor,
        child: Container(
          child: FutureBuilder<List>(
            future: assignmentRepository.findAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length > 0) {
                  return buildListView(snapshot.data);
                } else {
                  return Center(
                    child: Text(
                      "Nenhum trabalho cadastrado!",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.0,
                      ),
                    ),
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
      color: Color(0xff151819),
      margin: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Container(
            padding: EdgeInsets.only(top: 15.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: AutoSizeText(
                    assignment.subject,
                    style: TextStyle(
                      color: Color(0xffED145B),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 30.0,
                ),
              ],
            ),
          ),
          subtitle: assignmentCardSubtitle(assignment),
          onTap: () async {
            await Navigator.of(context)
                .pushNamed("/assignment_deliveries", arguments: assignment);
            if (this.mounted) {
              setState(() {});
            }
          },
        ),
      ),
    );
  }

  Column assignmentCardSubtitle(AssignmentModel assignment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        disciplineRow(assignment.disciplineId, assignment.classId),
        endDateRow(assignment.endDate),
        buildCardSubtitleData(assignment.id, "all"),
        buildCardSubtitleData(assignment.id, "nonRated"),
        buildCardSubtitleData(assignment.id, "rated"),
        observationsForm(assignment),
      ],
    );
  }

  Wrap disciplineRow(int disciplineId, int classId) {
    return Wrap(
      children: <Widget>[
        FutureBuilder<DisciplineModel>(
          future: disciplineRepository.getDiscipline(disciplineId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: AutoSizeText(
                          "${snapshot.data.name} - ",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      classRow(classId),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "Sem disciplina",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
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

  Widget classRow(int classId) {
    return Container(
      child: FutureBuilder<ClassModel>(
        future: classRepository.getClass(classId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: AutoSizeText(
                  "${snapshot.data.name}",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              );
            } else {
              return Text(
                "Sem turma",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Row endDateRow(DateTime endDate) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            "Data limite para a entrega: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          DateFormat("dd/MM/yyyy").format(endDate),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget buildCardSubtitleData(int assignmentId, String type) {
    return FutureBuilder<int>(
      future: assignmentRepository.getDeliveryAmount(assignmentId, type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return getTextBasedOnType(type, snapshot.data);
          } else {
            return Center(
              child: Text(
                "Um erro ocorreu na consulta.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
            );
          }
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
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                "Total de entregas: " + amount.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
        break;
      case "nonRated":
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Não avaliados: " + amount.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
        break;
      default:
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              child: Text(
                "Avaliados: " + amount.toString(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
    }
  }

  Row observationsForm(AssignmentModel assignment) {
    final GlobalKey<FormState> observationsFormKey = GlobalKey<FormState>();

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
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    icon: const Icon(
                      Icons.text_fields,
                      color: Color(0xffED145B),
                    ),
                    hintText: 'Digite suas observações...',
                    labelText: 'Observações',
                    hintStyle: TextStyle(fontSize: 16.0),
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
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
                  child: ButtonTheme(
                    buttonColor: Theme.of(context).primaryColor,
                    child: RaisedButton(
                      child: Text(
                        "Salvar Observações",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (observationsFormKey.currentState.validate()) {
                          observationsFormKey.currentState.save();
                          assignmentRepository.update(assignment);
                          showSnackBar('Observações salvas com sucesso!');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
