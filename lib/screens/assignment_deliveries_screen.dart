import 'package:FiapEx/components/app_bar_fiap_ex.dart';
import 'package:FiapEx/components/drawer_fiap_ex.dart';
import 'package:FiapEx/models/assignment_model.dart';
import 'package:FiapEx/models/comment_model.dart';
import 'package:FiapEx/models/delivery_model.dart';
import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/repository/assignment_delivery_repository.dart';
import 'package:FiapEx/repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  AssignmentDeliveryRepository assignmentDeliveryRepository =
      AssignmentDeliveryRepository();
  CommentRepository commentRepository = CommentRepository();

  DateFormat formatter = DateFormat("dd/MM/yyyy 'às' hh:mm:ss");

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarFiapEx(
          action: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Icon(Icons.chevron_left,color: Theme.of(context).primaryColor,),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      )),
      drawer: DrawerFiapEx(route: '/assignment',),
      body: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: deliveries(),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List> deliveries() {
    return FutureBuilder<List>(
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
                  students(delivery.id),
                ],
              ),
            ),
            subtitle: Column(
              children: <Widget>[
                deliveryDateRow(delivery),
                gradeForm(delivery),
                gradeGivenDateText(delivery),
                Text("Comentários:"),
                comments(delivery.id),
                commentForm(delivery.id),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<StudentModel>> students(int deliveryId) {
    return FutureBuilder<List<StudentModel>>(
      future: assignmentDeliveryRepository.findStudentsByDeliveryId(deliveryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length > 0) {
            return Row(
              children: <Widget>[studentsString(snapshot.data)],
            );
          } else {
            return Center(
              child:
                  Text("Algo deu errado... Não há integrantes cadastrados?!"),
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

  FutureBuilder<List<CommentModel>> comments(int deliveryId) {
    return FutureBuilder<List<CommentModel>>(
      future: commentRepository.findCommentsByDeliveryId(deliveryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length > 0) {
            List<Row> comments = List<Row>();

            for (int i = 0; i < snapshot.data.length; i++) {
              comments.add(
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data[i].message),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            formatter.format(snapshot.data[i].date),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: comments,
            );
          } else {
            return Text("Não há comentários.");
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Wrap deliveryDateRow(DeliveryModel delivery) {
    return Wrap(
      children: <Widget>[
        Container(
          child: Text(
            "Entregue: " + formatter.format(delivery.deliveryDate),
          ),
        ),
      ],
    );
  }

  Text gradeGivenDateText(DeliveryModel delivery) {
    if (delivery.gradeGivenDate != null) {
      return Text(
          "Nota publicada: " + formatter.format(delivery.gradeGivenDate));
    } else {
      return Text("A nota para esta entrega ainda não foi publicada.");
    }
  }

  Text studentsString(List<StudentModel> students) {
    String studentsString = "";

    for (int i = 0; i < students.length; i++) {
      studentsString += students[i].name;

      if (i + 1 < students.length) {
        studentsString += ", ";
      } else {
        studentsString += ".";
      }
    }

    return Text(studentsString);
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
              child: Text("Avaliar"),
              onPressed: () {
                if (gradeFormKey.currentState.validate()) {
                  delivery.gradeGivenDate = DateTime.now();

                  gradeFormKey.currentState.save();

                  assignmentDeliveryRepository.update(delivery);

                  showSnackBar('Nota salva com sucesso!');

                  if (this.mounted) {
                    setState(() {});
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Form commentForm(int deliveryId) {
    final GlobalKey<FormState> commentFormKey = new GlobalKey<FormState>();

    CommentModel comment = CommentModel(deliveryId: deliveryId);

    return Form(
      key: commentFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration(
              icon: const Icon(Icons.text_fields),
              hintText: 'Adicione um comentário...',
              labelText: 'Comentário',
            ),
            validator: (value) {
              if ((value.isEmpty)) {
                return 'Digite um comentário!';
              }

              return null;
            },
            keyboardType: TextInputType.text,
            onSaved: (value) {
              comment.message = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              child: Text("Postar"),
              onPressed: () {
                if (commentFormKey.currentState.validate()) {
                  comment.date = DateTime.now();

                  commentFormKey.currentState.save();

                  commentRepository.create(comment);

                  showSnackBar('Comentário publicado com sucesso!');

                  if (this.mounted) {
                    setState(() {});
                  }
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