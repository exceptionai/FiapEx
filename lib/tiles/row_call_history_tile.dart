import 'package:FiapEx/models/class_model.dart';
import 'package:FiapEx/models/discipline_model.dart';
import 'package:FiapEx/models/roll_model.dart';
import 'package:FiapEx/models/student.dart';
import 'package:FiapEx/repository/rollRegister_repository.dart';
import 'package:FiapEx/repository/student_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RowCallHistoryTile extends StatefulWidget {

  RollModel rowModel;
  VoidCallback onChanged;

  RowCallHistoryTile({this.rowModel, this.onChanged});

  @override
  _RowCallHistoryTileState createState() => _RowCallHistoryTileState();
}

class _RowCallHistoryTileState extends State<RowCallHistoryTile> {
  StudentRepository studentRepository = new StudentRepository();

  RollRegisterRepository rollRegisterRepository = new RollRegisterRepository();

  ClassModel rowCallClass;

  DisciplineModel rowCallDiscipline;
  int rowCallPresentStudentsCount;
  int rowCallAbsentStudentsCount;
  int studentsCount;

  @override
  void initState() { 
    super.initState();
    getHistoryTileData();
  }

  getHistoryTileData(){
    getRowCallHistoryClass();
    getRowCallDiscipline();
    getRowCallPresentStudentsCount();
    getRowCallAbsentStudentsCount();
  
  }

  getRowCallStudentsCount() async{
    List<StudentModel> students = widget.rowModel.students;
    setState((){
      studentsCount = students.length;
    });
  }

  getRowCallPresentStudentsCount() async{
    setState((){
      rowCallPresentStudentsCount = widget.rowModel.presentStudents;
    });
  }

  getRowCallAbsentStudentsCount() async{
    setState((){
      rowCallAbsentStudentsCount = widget.rowModel.absentStudents;
    });
  }

  getRowCallHistoryClass() async{
    setState((){
      rowCallClass = widget.rowModel.studentClass;

      getRowCallStudentsCount();
    });
  }

  getRowCallDiscipline() async{
    setState((){
      rowCallDiscipline = widget.rowModel.discipline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.only(bottom: 15),
      child: Theme(
        data: Theme.of(context).copyWith(textTheme: TextTheme(
          subtitle1:  TextStyle(color: Colors.white,fontSize: 20,
          fontFamily: 'GothamHTF',),
        ),),
              child: ListTile(
          onTap: () async {
            await Navigator.of(context).pushNamed('/rowcall', arguments: widget.rowModel);
            widget.onChanged();
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${rowCallDiscipline != null ? rowCallDiscipline.name : ''} - ${rowCallClass != null ? rowCallClass.name : ''}',
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Text('Data: ', style: TextStyle(fontSize: 14)),
                  Text('${DateFormat('dd/MM/yyyy').format(widget.rowModel.date)}', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Status: ', style: TextStyle(fontSize: 14)),
                  Text('${widget.rowModel.done ? 'Finalizado' : 'Pendente'}', style: TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Alunos: ', style: TextStyle(fontSize: 14)),
                  Text('${studentsCount != null ? studentsCount : ''}',
                      style:
                          TextStyle(fontSize: 16, color: Colors.lightBlueAccent)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ausentes: ',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text('${rowCallAbsentStudentsCount != null ? rowCallAbsentStudentsCount : ''}',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent)),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Presentes: ', style: TextStyle(fontSize: 14)),
                  Text('${rowCallPresentStudentsCount != null ? rowCallPresentStudentsCount : ''} ',
                      style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
                ],
              )
            ],
          ),
          leading: 
             widget?.rowModel?.done != null && widget.rowModel.done ? Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Image.asset(
                    'assets/images/presenteicone.png',
                    width: 40,
                  ),
              )
              : Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Image.asset(
                    'assets/images/pendenteicone.png',
                    width: 40,
                  ),
              ),
        ),
      ),
    );
  }
}
